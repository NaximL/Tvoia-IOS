//
//  Widget.swift
//  Tvoia
//
//  Created by Maxim Loza on 21.01.2026.
//

import SwiftUI

struct WidgetView: View {
    
    let item: Widgetd
    let index: Int
    @Environment(\.colorScheme) var scheme

        
    var body: some View {
        Group {
            if #available(iOS 26, *) {
                Header
                    .glassEffect(
                        [0, 1].contains(index) ? .clear : .regular,
                        in: .rect(cornerRadius: 36.0)
                    )
            } else {
                Header
                    .background(
                                            ZStack {
                                                // Основной фон
                                                RoundedRectangle(cornerRadius: 36)
                                                    .fill(Color(hex: "#1c1c1e"))
                                                
                                                // Верхний блик
                                                RoundedRectangle(cornerRadius: 36)
                                                    .stroke(
                                                        LinearGradient(
                                                            colors: [
                                                                Color.white.opacity(0.2),
                                                                Color.white.opacity(0.1),
                                                                Color.clear,
                                                                Color.white.opacity(0.2),
                                                                Color.white.opacity(0.4)
                                                            ],
                                                            startPoint: .top,
                                                            endPoint: .bottomTrailing
                                                        ),
                                                        lineWidth: 1
                                                    )
                                                    .blur(radius: 1.5)
                                                    .blendMode(.overlay)
                                                
                                                
                                            }
                                        )
                                        .shadow(color: Color.black.opacity(0.25), radius: 10, x: 0, y: 5)
            }
        }
        
        
    }
    
    private var Header: some View {
        VStack(spacing:-15) {
            HStack() {
                HStack(alignment: .center, spacing: 3) {
                    Image(systemName: item.icon)
                        .font(.system(size: 18))
                        .foregroundStyle(item.color)

                    Text(item.title)
                        .font(.headline)
                        .foregroundStyle(item.color)

                }
                
                Spacer()
                
                if let time = item.time {
                HStack(spacing: 3,) {
                    Text(time)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(scheme == .dark ? .white.opacity(0.5) : .black.opacity(0.5))

                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(scheme == .dark ? .white.opacity(0.5) : .black.opacity(0.5))
                }
                }
                
            }
            .padding(3)
            
            
            item.content

        }
        .frame(maxWidth: .infinity)
        .frame(minHeight: 113)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding()
    }
}
