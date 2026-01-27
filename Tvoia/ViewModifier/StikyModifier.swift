//
//  StikyModifier.swift
//  Tvoia
//
//  Created by Maxim Loza on 26.01.2026.
//

import SwiftUI

// MARK: - ViewModifier
struct StikyModifier: ViewModifier {
    @Binding var hidden: Bool
    var threshold: CGFloat = 0

    func body(content: Content) -> some View {
        content
        .background(
            GeometryReader { geo in
                Color.clear
                    .onChange(of: geo.frame(in: .global).minY) { _, newY in
                        let shouldHide = newY < threshold
                        if shouldHide != hidden {
                            withAnimation(.easeInOut(duration: 0.25)) {
                                hidden = shouldHide
                            }
                        }
                    }
            }
        )
    }
}

// MARK: - View Extension для удобства
extension View {
    func headerVisibility(hidden: Binding<Bool>, threshold: CGFloat = 0) -> some View {
        self.modifier(StikyModifier(hidden: hidden, threshold: threshold))
    }
}

