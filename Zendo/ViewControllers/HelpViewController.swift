import SwiftUI

struct HelpView: View {
    @Environment(\.horizontalSizeClass) var sizeClass

    private var isRegular: Bool { sizeClass == .regular }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                HStack {
                    Spacer()
                    EnsoView(size: isRegular ? 120 : 80)
                    Spacer()
                }
                .padding(.top, 20)

                Text("Welcome to\nMini Zendo")
                    .font(.system(size: isRegular ? 42 : 32, weight: .bold))

                Text("A simple meditation timer for your practice.")
                    .font(.system(size: isRegular ? 22 : 18))
                    .foregroundStyle(.secondary)

                VStack(alignment: .leading, spacing: isRegular ? 28 : 20) {
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
            .padding(isRegular ? 60 : 30)
            .frame(maxWidth: isRegular ? 600 : .infinity, alignment: .leading)
            .frame(maxWidth: .infinity)
        }
        .background(Color.zendoBackground.ignoresSafeArea())
    }

    private func helpItem(icon: String, title: String, description: String) -> some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: icon)
                .font(isRegular ? .title : .title2)
                .foregroundStyle(.primary)
                .frame(width: 32)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: isRegular ? 20 : 17, weight: .semibold))
                Text(description)
                    .font(.system(size: isRegular ? 18 : 15))
                    .foregroundStyle(.secondary)
            }
        }
    }
}
