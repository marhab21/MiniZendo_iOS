import SwiftUI

struct HelpView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                HStack {
                    Spacer()
                    EnsoView(size: 80)
                    Spacer()
                }
                .padding(.top, 20)

                Text("Welcome to\nMini Zendo")
                    .font(.system(size: 32, weight: .bold))

                Text("A simple meditation timer for your practice.")
                    .font(.system(size: 18))
                    .foregroundStyle(.secondary)

                VStack(alignment: .leading, spacing: 20) {
                    helpItem(
                        icon: "plus.circle.fill",
                        title: "Create a Session",
                        description: "Tap the + button to add a new meditation timer with your preferred duration."
                    )

                    helpItem(
                        icon: "play.circle.fill",
                        title: "Start Meditating",
                        description: "Tap any session from your list to begin. A circular timer will track your progress."
                    )

                    helpItem(
                        icon: "bell.fill",
                        title: "Session Complete",
                        description: "A bell sounds when your session ends, followed by an inspiring Zen quote."
                    )

                    helpItem(
                        icon: "hand.draw.fill",
                        title: "Remove Sessions",
                        description: "Swipe left on any session to remove it from your list."
                    )
                }
                .padding(.top, 8)
            }
            .padding(30)
        }
        .background(Color.zendoBackground.ignoresSafeArea())
    }

    private func helpItem(icon: String, title: String, description: String) -> some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(.black)
                .frame(width: 32)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 17, weight: .semibold))
                Text(description)
                    .font(.system(size: 15))
                    .foregroundStyle(.secondary)
            }
        }
    }
}
