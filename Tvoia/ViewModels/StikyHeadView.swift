//
//  StikyHeadView.swift
//  Tvoia
//
//  Created by Maxim Loza on 24.01.2026.
//

import SwiftUI

struct StikyHeadView: View {
    let headerHidden: Bool
    let Title: String
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                LinearGradient(
                    colors: [
                        Color.black.opacity(0.5),
                        Color.black.opacity(0.2),
                        Color.clear
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 150)
                .opacity(headerHidden ? 1 : 0)
                if #available(iOS 26, *) {
                Text(Title)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.primary)
                    .padding()
                    .padding(.vertical,-3)
                    .glassEffect(.regular)
                    .opacity(headerHidden ? 1 : 0)
                    .offset(y: headerHidden ? 10 : 0)
                }
                else {
                    Text(Title)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.primary)
                        .padding()
                        .opacity(headerHidden ? 1 : 0)
                        .offset(y: headerHidden ? 10 : 0)
                }
            }
            .ignoresSafeArea(edges: .top)

            Spacer()
        }
        .animation(.easeInOut(duration: 0.3), value: headerHidden)
        .zIndex(1)
    
    }
}
