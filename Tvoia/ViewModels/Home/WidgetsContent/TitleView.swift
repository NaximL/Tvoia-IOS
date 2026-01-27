//
//  TitleView.swift
//  Tvoia
//
//  Created by Maxim Loza on 22.01.2026.
//

import SwiftUI

struct TitleView: View {
    let TitleText: String
    let TitlePostText: String
    let Size: CGFloat
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
            VStack() {
                Spacer()
                HStack(alignment: .bottom,spacing: 3) {
                    
                        Text(TitleText)
                            .font(.system(size: Size, weight: .bold))
                            .lineLimit(1)
                            .truncationMode(.tail)
         
         
                        Text(TitlePostText)
                        .offset(y:-2)
                            .font(Font.system(size: 18, weight: .semibold))
                            .foregroundStyle(scheme == .dark ? .white.opacity(0.5) : .black.opacity(0.5))
                            .lineLimit(1)
                            .truncationMode(.tail)
                
  

                    
                }
            }
    }
    
}




