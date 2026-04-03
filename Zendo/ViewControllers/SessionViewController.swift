import SwiftUI

struct SessionTimerView: View {
    let session: Session
    @Environment(\.dismiss) var dismiss
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.horizontalSizeClass) var sizeClass

    @State private var timeRemaining: TimeInterval
    @State private var endTime: Date?
    @State private var isRunning = false
    @State private var isFinished = false
    @State private var quote = ""
    @State private var progress: CGFloat = 0

    private var isRegular: Bool { sizeClass == .regular }
    private var ringSize: CGFloat { isRegular ? 260 : 160 }
    private var ringWidth: CGFloat { isRegular ? 24 : 18 }
    private var timerFontSize: CGFloat { isRegular ? 48 : 32 }
    private var quoteFontSize: CGFloat { isRegular ? 40 : 32 }
    private var titleFontSize: CGFloat { isRegular ? 30 : 24 }

    init(session: Session) {
        self.session = session
        _timeRemaining = State(initialValue: TimeInterval(session.durationInSeconds))
    }

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.black.ignoresSafeArea()

                if let img = UIImage(named: "narrows.jpg") {
                    Image(uiImage: img)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipped()
                        .opacity(0.8)
                }

                if isFinished {
                    quoteOverlay
                } else {
                    timerOverlay
                }
            }
        }
        .ignoresSafeArea()
        .toolbar {
            ToolbarItem(placement: .principal) {
                if !isFinished {
                    Text("Zazen Time...")
                        .font(.system(size: titleFontSize, weight: .bold))
                        .foregroundStyle(.white)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .onAppear(perform: startSession)
        .onDisappear(perform: cleanup)
        .onChange(of: scenePhase) { oldPhase, newPhase in
            if newPhase == .background {
                cleanup()
                dismiss()
            }
        }
    }

    // MARK: - Timer Display

    private var timerOverlay: some View {
        VStack {
            Spacer()
            Spacer()

            ZStack {
                Circle()
                    .stroke(Color.black.opacity(0.2), lineWidth: ringWidth)
                    .frame(width: ringSize, height: ringSize)

                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        Color.zendoGreen,
                        style: StrokeStyle(lineWidth: ringWidth, lineCap: .round)
                    )
                    .frame(width: ringSize, height: ringSize)
                    .rotationEffect(.degrees(-90))

                Text(timeString)
                    .font(.system(size: timerFontSize, weight: .medium, design: .monospaced))
                    .foregroundStyle(Color.zendoGreen)
            }

            Spacer()
        }
        .padding(.top, isRegular ? 60 : 100)
    }

    // MARK: - End Quote

    private var quoteOverlay: some View {
        VStack {
            Spacer()

            Text(quote)
                .font(.system(size: quoteFontSize, weight: .medium, design: .serif))
                .italic()
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, isRegular ? 80 : 24)
                .shadow(color: .black.opacity(0.6), radius: 3, x: 0, y: 2)

            Spacer()
            Spacer()
        }
    }

    // MARK: - Timer Logic

    private var timeString: String {
        let total = max(0, Int(ceil(timeRemaining)))
        let m = total / 60
        let s = total % 60
        return String(format: "%02d:%02d", m, s)
    }

    private func startSession() {
        guard !isRunning else { return }
        UIApplication.shared.isIdleTimerDisabled = true
        SoundPlayer.playCustomSound(name: "sms_alert_note", ext: "caf")

        endTime = Date().addingTimeInterval(TimeInterval(session.durationInSeconds))
        isRunning = true

        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            guard isRunning, let endTime else {
                timer.invalidate()
                return
            }

            timeRemaining = endTime.timeIntervalSinceNow
            let totalDuration = TimeInterval(session.durationInSeconds)
            let elapsed = totalDuration - timeRemaining
            progress = min(CGFloat(elapsed / totalDuration), 1.0)

            if timeRemaining <= 0 {
                timer.invalidate()
                timeRemaining = 0
                progress = 1.0
                finishSession()
            }
        }
    }

    private func finishSession() {
        guard !isFinished else { return }
        SoundPlayer.playCustomSound(name: "bell", ext: "mp3")
        isFinished = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeIn(duration: 0.6)) {
                quote = session.randomQuote()
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
            cleanup()
            dismiss()
        }
    }

    private func cleanup() {
        isRunning = false
        quote = ""
        UIApplication.shared.isIdleTimerDisabled = false
    }
}
