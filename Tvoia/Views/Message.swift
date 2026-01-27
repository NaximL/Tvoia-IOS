//
//  Message.swift
//  Tvoia
//
//  Created by Maxim Loza on 26.01.2026.
//
import SwiftUI

struct MessageModal: View {
    let message: Message
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var scheme

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Заголовок и инфо
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(message.isRead ? .green : .red)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(message.sender)
                                .font(.headline)
                                .bold()
                            Text("Кому: example@domain.com")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("Тема: \(message.topic)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                    .padding(.top, 16)
                    
                    Divider()
                    
                    // Содержимое письма
                    Text(message.pred)
                        .font(.body)
                        .padding(.bottom, 16)
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            .navigationTitle("Повідомлення")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.primary)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { print("Reply tapped") }) {
                        Image(systemName: "arrowshape.turn.up.left")
                    }
                }
            }
            .background(
                scheme == .dark ? Color.black : Color.white
            )
        }
    }
}
