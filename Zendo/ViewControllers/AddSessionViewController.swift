import SwiftUI

struct AddSessionView: View {
    @EnvironmentObject var store: SessionStore
    @Environment(\.dismiss) var dismiss
    @State private var hours = 0
    @State private var minutes = 10
    @State private var showingError = false
    @State private var errorMessage = ""

    var body: some View {
        VStack(spacing: 0) {
            Text("Set Sitting Time")
                .font(.system(size: 22, weight: .bold))
                .padding(.top, 10)
                .padding(.bottom, 8)

            HStack(spacing: 0) {
                Picker("Hours", selection: $hours) {
                    ForEach(0..<24, id: \.self) { h in
                        Text("\(h) hours").fontWeight(.bold).tag(h)
                    }
                }
                .pickerStyle(.wheel)
                .frame(maxWidth: .infinity)

                Picker("Minutes", selection: $minutes) {
                    ForEach(1..<60, id: \.self) { m in
                        Text("\(m) min").fontWeight(.bold).tag(m)
                    }
                }
                .pickerStyle(.wheel)
                .frame(maxWidth: .infinity)
            }
            .frame(height: 180)
            .background(Color.gray.opacity(0.3))

            Button(action: saveSession) {
                Text("SAVE")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }
            .padding(.horizontal, 30)
            .padding(.top, 30)

            if let img = UIImage(named: "torii_bkg.jpg") {
                Image(uiImage: img)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 180)
                    .padding(.top, 20)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.zendoBackground.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .alert("Error", isPresented: $showingError) {
            Button("OK") {}
        } message: {
            Text(errorMessage)
        }
    }

    private func saveSession() {
        let totalSeconds = (hours * 3600) + (minutes * 60)

        guard totalSeconds > 0 else {
            errorMessage = "Please select a duration greater than zero."
            showingError = true
            return
        }

        guard !store.hasDuplicate(duration: totalSeconds) else {
            errorMessage = "\(AlertMessages.duplicateTime). \(AlertMessages.noSession)"
            showingError = true
            return
        }

        guard !store.isFull else {
            errorMessage = "Maximum number of sessions reached."
            showingError = true
            return
        }

        let session = Session(durationInSeconds: totalSeconds)
        store.add(session)
        dismiss()
    }
}
