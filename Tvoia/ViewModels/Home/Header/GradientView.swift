import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255

        self.init(red: r, green: g, blue: b)
    }
}

struct GradientView: View {
    let width: CGFloat = 400
    let height: CGFloat = 300
    let baseOffsetY: CGFloat = -300
    let radius: CGFloat = 120
    
    @Environment(\.colorScheme) var scheme

    var colors: [Color] {
        if scheme == .dark {
            return [
                Color(hex: "#1E4D8B"),
                Color(hex: "#6D3A7C"),
                Color(hex: "#8B3A3A"),
                Color(hex: "#2A1F3D")
            ]
        } else {
            return [
                Color(hex: "#4F83CC"),
                Color(hex: "#B26DD9"),
                Color(hex: "#E07A7A"),
                Color(hex: "#ab8af2")
            ]
        }
    }

    let phaseShifts: [Double] = [0, 90, 180, 270]

    var body: some View {
        Text("Вовченко😏")
            .font(.title)
            .bold()
            .offset(x:0,
                    y: -350 + baseOffsetY).zIndex(1000)
        
        TimelineView(.animation) { timeline in
            let time = timeline.date.timeIntervalSinceReferenceDate
            let angle = time * .pi / 10

            ZStack {
                ForEach(colors.indices, id: \.self) { i in
                    let color = colors[i]
                    let phase = phaseShifts[i]

                    RadialGradient(
                        colors: [
                            color.opacity(scheme == .dark ? 1 : 0.9),
                            .clear
                        ],
                        center: .center,
                        startRadius: 20,
                        endRadius: 350
                    )
                    .frame(width: width, height: height)
                    .offset(
                        x: radius * CGFloat(cos(angle + phase * .pi / 180)),
                        y: radius * CGFloat(sin(angle + phase * .pi / 180)) + baseOffsetY
                    )
                }
            }
            .blur(radius: scheme == .dark ? 60 : 30)
            .saturation(scheme == .dark ? 1.0 : 1.35)
            .contrast(scheme == .dark ? 1.0 : 1.15)
            .ignoresSafeArea()
        }
    }
}
