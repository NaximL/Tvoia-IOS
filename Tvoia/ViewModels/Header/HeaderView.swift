//
//  HeaderView.swift
//  Tvoia
//
//  Created by Maxim Loza on 23.01.2026.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Text("Закріплені")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding()
            Spacer();
            
            if #available(iOS 26.0, *) {
                Button(action: {print(123)}) {
                    Text("Змінити")
                        .font(.system(size: 18, weight: .semibold))
                        .padding(.vertical,5)
                }	
                .padding(.horizontal)
                .buttonStyle(.glass)
            }
            else {
                Button(action: {print(123)}) {
                    Text("Змінити")
                }
                .padding()
                .background(.ultraThinMaterial)
            }
            
        }
    }
}

