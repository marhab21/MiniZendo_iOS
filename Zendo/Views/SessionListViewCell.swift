import SwiftUI

// MARK: - Adaptive Color Palette

extension Color {
    static let zendoBackground = Color(uiColor: UIColor { traits in
        traits.userInterfaceStyle == .dark
            ? UIColor(red: 30/255, green: 30/255, blue: 32/255, alpha: 1)
            : UIColor(red: 203/255, green: 202/255, blue: 183/255, alpha: 1)
    })

    static let zendoGreen = Color(uiColor: UIColor { traits in
        traits.userInterfaceStyle == .dark
            ? UIColor(red: 70/255, green: 180/255, blue: 120/255, alpha: 1)
            : UIColor(red: 51/255, green: 153/255, blue: 102/255, alpha: 1)
    })

    static let zendoSaveButton = Color(uiColor: UIColor { traits in
        traits.userInterfaceStyle == .dark
            ? UIColor.white
            : UIColor.black
    })

    static let zendoSaveText = Color(uiColor: UIColor { traits in
        traits.userInterfaceStyle == .dark
            ? UIColor.black
            : UIColor.white
    })

    static let zendoPickerBg = Color(uiColor: UIColor { traits in
        traits.userInterfaceStyle == .dark
            ? UIColor(white: 0.15, alpha: 1)
            : UIColor(white: 0.0, alpha: 0.15)
    })

    static let zendoZenBg = Color(uiColor: UIColor { traits in
        traits.userInterfaceStyle == .dark
            ? UIColor(white: 0.55, alpha: 1)
            : UIColor.clear
    })
}

// MARK: - Enso (Zen Circle)

struct EnsoShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2 * 0.85

        path.addArc(
            center: center,
            radius: radius,
            startAngle: .degrees(-20),
            endAngle: .degrees(310),
            clockwise: false
        )
        return path
    }
}

struct EnsoView: View {
    var size: CGFloat = 50

    var body: some View {
        ZStack {
            EnsoShape()
                .stroke(style: StrokeStyle(lineWidth: size * 0.18, lineCap: .round))
                .foregroundStyle(.primary)
                .frame(width: size, height: size)

            Circle()
                .fill(.primary)
                .frame(width: size * 0.14, height: size * 0.14)
                .offset(x: size * 0.28, y: size * 0.22)
        }
    }
}
