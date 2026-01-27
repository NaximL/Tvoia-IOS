//
//  ListView.swift
//  Tvoia
//
//  Created by Maxim Loza on 23.01.2026.
//


import SwiftUI



struct ListView: View {
    
    struct ListItem: Identifiable {
        let id = UUID()
        let who: String
        let text: String
    }
    let Messages: [ListItem];
    
    var body: some View {
        VStack {
            ForEach(Messages.indices, id: \.self) { index in
                let item = Messages[index]
                
                VStack(spacing: 3) {
                    HStack {
                        Text(item.who)
                            .font(.system(
                                size: 14,
                                weight: .bold
                            ))
                            .lineLimit(1)
                            .truncationMode(.tail)
                        Spacer()
                    }
                    HStack {
                        Text(item.text)
                            .font(.system(
                            size: 12,
                            weight: .semibold
                        ))
                            .foregroundStyle(.primary.opacity(0.7))
                            .lineLimit(1)
                            .truncationMode(.tail)
                        Spacer()
                    }
                    if index != Messages.count - 1 {
                        Divider()
                    }
                }
            }
        }
        .frame(width: 150)
        .padding(.top,20)
    }
    
}




