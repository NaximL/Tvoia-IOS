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
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(message.isRead ? .green : .red)

                        VStack(alignment: .leading, spacing: 4) {
                            Text(message.topic)
                                .font(.title2)
                                .bold()
                            Text("Від: \(message.sender)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Divider()
                            Text("Кому: Класу")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Divider()
                            Text("Предмет: \(message.pred)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                    .padding(.top, 16)

                    Divider()

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
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button(action: { dismiss() }) {
//                        Image(systemName: "xmark")
//                            .foregroundColor(.primary)
//                    }
//                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button {
                            print("Reply tapped")
                        } label: {
                            Label("Відповісти", systemImage: "arrowshape.turn.up.left")
                        }

                        Button {
                            UIPasteboard.general.string = message.pred
                        } label: {
                            Label("Скопіювати текст", systemImage: "doc.on.doc")
                        }

                    } label: {
                        Image(systemName: "ellipsis")
                    }
                }
            }
            .background(scheme == .dark ? Color.black : Color.white)
        }
    }
}

