import SwiftUI

// MARK: - Color Palette

extension Color {
    static let zendoBackground = Color(red: 203/255, green: 202/255, blue: 183/255)
    static let zendoGreen = Color(red: 51/255, green: 153/255, blue: 102/255)
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
                .foregroundStyle(.black)
                .frame(width: size, height: size)

            Circle()
                .fill(.black)
                .frame(width: size * 0.14, height: size * 0.14)
                .offset(x: size * 0.28, y: size * 0.22)
        }
    }
}
