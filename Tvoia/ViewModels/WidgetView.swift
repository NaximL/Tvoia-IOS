//
//  Widget.swift
//  Tvoia
//
//  Created by Maxim Loza on 21.01.2026.
//

import SwiftUI

struct Widget: View {
    
    
//    let Icon: String
    let text: String
    
    
    
    var body: some View {
        Group {
            if #available(iOS 26, *) {
                Header
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 32))
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 0, y: 6)
                    
            } else {
                Header
                    .background(.ultraThinMaterial)
            }
        }
        
        
    }
    
    private var Header: some View {
        VStack(spacing:-5) {
            HStack() {
                HStack(spacing: 5) {
                    Image(systemName: "house.fill")
                        .font(.system(size: 20))
                    
                    Text(text)
                        .font(.headline)
                }
                
                Spacer()
                
                HStack(spacing: 3,) {
                    Text("20:10")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.black.opacity(0.5))
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.black.opacity(0.5))
                }
            }
            
            
            
            Content()
        }
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .padding()
    }
}
