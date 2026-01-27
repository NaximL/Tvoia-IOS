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
                    .background(.ultraThinMaterial)
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
                
                HStack(spacing: 3,) {
                    Text(item.time)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(scheme == .dark ? .white.opacity(0.5) : .black.opacity(0.5))

                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(scheme == .dark ? .white.opacity(0.5) : .black.opacity(0.5))
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
