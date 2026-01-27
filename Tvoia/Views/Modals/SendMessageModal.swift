//
//  SendMessageModal.swift
//  Tvoia
//
//  Created by Maxim Loza on 26.01.2026.
//

import SwiftUI

struct SendMessage: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var scheme

    @State private var subject = ""
    @State private var message = ""
    @State private var theme = "Новий лист"
    @State private var isReady = false

    @State private var receiverType: String?
    @State private var receiver: String?

    let receiverTypeMenu = [
        "Учні свого класу",
        "Вчителі"
    ]

    let studentsMenu = [
        "Іван Петренко",
        "Марія Коваль",
        "Антон Лоза"
    ]

    let teachersMenu = [
        "Вчитель: Математика",
        "Вчитель: Українська",
        "Вчитель: Фізика"
    ]
    
    var receiverTypeIcons: [String: String] {
        [
            "Учні свого класу": "person.2",
            "Вчителі": "person.crop.circle"
        ]
    }
    
    var studentsIcons: [String: String] {
        [
            "Іван Петренко": "person",
            "Марія Коваль": "person",
            "Антон Лоза": "person"
        ]
    }
    
    var teachersIcons: [String: String] {
        [
            "Вчитель: Математика": "book.closed",
            "Вчитель: Українська": "book.closed",
            "Вчитель: Фізика": "book.closed"
        ]
    }
    
    var selectedMenu: ([String], [String: String]) {
        if receiverType == "Учні свого класу" {
            return (studentsMenu, studentsIcons)
        } else {
            return (teachersMenu, teachersIcons)
        }
    }

    var selectedList: [String] {
        receiverType == "Учні свого класу" ? studentsMenu : teachersMenu
    }

    var body: some View {
        VStack(spacing: 16) {

            // MARK: Header
            HStack {
                if #available(iOS 26, *) {
                    Button(action: {dismiss()}) {
                        Image(systemName: "xmark")
                            .font(.system(size: 23, weight: .semibold))
                            .frame(width: 23,height: 23)
                            .padding()
                            .glassEffect(.regular.interactive())
                            
                    }
                    .foregroundStyle(.primary)
                
                
                
                Spacer()
                Button(action: {sendMail()}) {
                    Image(systemName: "arrow.up")
                        .font(.system(size: 23, weight: .semibold))
                        .frame(width: 23,height: 23)
                        .padding()
                        .glassEffect(
                            isReady
                            ? .regular.interactive().tint(.blue.mix(with: .white, by: 0.05))
                            : .regular.interactive()
                        )
                        
                }
                .foregroundStyle(.primary)
                .disabled(!isReady)
                }
 
               
                
            }
            .padding()

            // MARK: Title
            Text(theme)
                .font(.largeTitle.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

            // MARK: Form
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {

                    Text("Кому:")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Menu {
                        ForEach(receiverTypeMenu, id: \.self) { item in
                            Button(action: {
                                receiverType = item
                                receiver = nil
                                isReady = false
                            }) {
                                HStack {
                                    Label(item, systemImage: receiverTypeIcons[item] ?? "person.2")
                                        .font(Font.body.bold())
                                    Spacer(minLength: 8)
                                    if receiverType == item {
                                        Image(systemName: "checkmark")
                                            .foregroundStyle(.blue)
                                            
                                    }
                                }
                            }
                        }
                        Divider()
                        Button(role: .destructive) {
                            receiverType = nil
                            receiver = nil
                            isReady = false
                        } label: {
                            Label("Скинути вибір", systemImage: "xmark.circle")
                        }
                    } label: {
                        pickerRow(title: receiverType ?? "Кому відправити?", systemImage: receiverTypeIcons[receiverType ?? ""] ?? "person.2")
                    }

                    if receiverType != nil {
                        let (list, icons) = selectedMenu
                        Menu {
                            ForEach(list, id: \.self) { item in
                                Button(action: {
                                    receiver = item
                                    isReady = !subject.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                                }) {
                                    HStack {
                                        Label(item, systemImage: icons[item] ?? "person")
                                        Spacer(minLength: 8)
                                        if receiver == item {
                                            Image(systemName: "checkmark")
                                                .foregroundStyle(.blue)
                                        }
                                    }
                                }
                            }
                            Divider()
                            Button(role: .destructive) {
                                receiver = nil
                                isReady = false
                            } label: {
                                Label("Скинути вибір", systemImage: "xmark.circle")
                            }
                        } label: {
                            pickerRow(title: receiver ?? "Оберіть отримувача", systemImage: icons[receiver ?? ""] ?? "person")
                        }
                    }

                    Divider().padding(.vertical, 6)

                    Text("Тема:")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    TextField("Тема", text: $subject)
                        .textFieldStyle(.plain)
                        .font(.body)
                        .onChange(of: subject) { value in
                            if value.isEmpty {
                                theme = "Новий лист"
                                isReady = false
                            } else {
                                theme = value
                                isReady = true
                            }
                        }

                    Divider()

                    TextEditor(text: $message)
                        .frame(minHeight: 260)
                        .scrollContentBackground(.hidden)
                }
                .padding()
            }
            HStack {
                Spacer()
                if #available(iOS 26, *) {
                    Menu {
                        Button {
                            print(123)
                        } label: {
                            Label("Прикріпити файл", systemImage: "paperclip")
                        }
                        Button {
                            print(312)
                        } label: {
                            Label("Зробити фото", systemImage: "camera")
                        }
                    } label: {
                        Image(systemName: "paperclip")
                            .font(.system(size: 23, weight: .semibold))
                            .frame(width: 23,height: 23)
                            .symbolEffect(.bounce, value: UUID())
                            .padding()
                            .glassEffect(.regular.interactive())
                    }
                    .foregroundStyle(.primary)

                }
            }
            .padding(.horizontal)
            
            
            
        }
        .background(.ultraThinMaterial)
        .presentationDetents([.large])
        .presentationDragIndicator(.hidden)
    }

    // MARK: Components

    func glassButton(system: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: system)
                .font(.title3.weight(.medium))
                .frame(width: 44, height: 44)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
        }
    }

    func pickerRow(title: String, systemImage: String? = nil) -> some View {
        HStack(spacing: 12) {
            if let systemImage {
                Image(systemName: systemImage)
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
                
            }
            Text(title)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
            Spacer()
            Image(systemName: "chevron.down")
                .foregroundStyle(.white)
        }
        .padding()
        .background(scheme == .dark ? .white.opacity(0.08) : .black.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    func sendMail() {
        print("Send:", subject, message, receiver ?? "", receiverType ?? "")
        dismiss()
    }
}


