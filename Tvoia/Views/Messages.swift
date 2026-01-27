

import SwiftUI

// MARK: - Model
struct Message: Identifiable {
    let id: Int
    let sender: String
    let topic: String
    let pred: String
    let date: String
    let isRead: Bool
}

// MARK: - Messages Screen
struct MessagesScreen: View {

    @Environment(\.colorScheme) private var colorScheme
    @State private var headerHidden = false
    @State private var modal = false
    @State private var selectedFilter = 0
    @State private var selectedMessage: Message? = nil

    let filters = ["Вхідні", "Вихідні"]

    @State private var messages: [Message] = [
        Message(id: 1, sender: "Олефіренко Світлана Іванівна", topic: "Колоквіум", pred: "Фізика", date: "Учора", isRead: true),
        Message(id: 2, sender: "Іванова Вікторія Віталіївна", topic: "Завдання на урок", pred: "Фізика", date: "Пʼятниця, 12:28", isRead: true),
        Message(id: 3, sender: "Якименко Наталія Олегівна", topic: "УЛ_10М_07_11", pred: "Фізика", date: "07.11, 11:10", isRead: false),
        Message(id: 4, sender: "Іванова Вікторія", topic: "Завдання на урок", pred: "Фізика", date: "07.11, 00:00", isRead: true),
        Message(id: 5, sender: "Іванова Вікторія", topic: "Завдання на урок", pred: "Фізика", date: "07.11, 00:00", isRead: true),
        Message(id: 6, sender: "Іванова Вікторія", topic: "Завдання на урок", pred: "Фізика", date: "07.11, 00:00", isRead: true),
        Message(id: 7, sender: "Іванова Вікторія", topic: "Завдання на урок", pred: "Фізика", date: "07.11, 00:00", isRead: true),
        Message(id: 8, sender: "Іванова Вікторія", topic: "Завдання на урок", pred: "Фізика", date: "07.11, 00:00", isRead: true),
        Message(id: 9, sender: "Іванова Вікторія", topic: "Завдання на урок", pred: "Фізика", date: "07.11, 00:00", isRead: true),
        Message(id: 10, sender: "Іванова Вікторія", topic: "Завдання на урок", pred: "Фізика", date: "07.11, 00:00", isRead: true),
    ]

    struct BottomView : View {
        @State private var text = ""
        @Binding var modal: Bool
        var body: some View {
            if #available(iOS 26.0, *) {
                GlassEffectContainer(spacing: 15) {
                    HStack(spacing:10) {
                        Menu {
                            Button { } label: { Label("Add to Favorites", systemImage: "heart") }
                            Button { } label: { Label("Show in Maps", systemImage: "mappin") }
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease")
                                .font(.system(size: 23, weight: .semibold))
                                .frame(width: 23, height: 23)
                                .padding()
                                .foregroundColor(.primary)
                                .glassEffect(.regular.interactive())
                        }

                        HStack {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 20, weight: .medium))
                            TextField("Пошук", text: $text)
                                .font(.title3).bold()
                                .frame(width: 150)
                        }
                        .padding()
                        .frame(height: 52)
                        .glassEffect(.regular.interactive())
                        
                        Button(
                            action:{
                                modal=true
                            }) {
                            Image(systemName: "square.and.pencil")
                                .font(.system(size: 23, weight: .semibold))
                                .frame(width: 23,height: 23)
                                .padding()
                                .glassEffect(.regular.interactive())
                                
                        }.foregroundStyle(.primary)
                    }
                    .padding()
                }
            }
            else if #available(iOS 15.0, *) {
                // iOS 15–25 fallback: Material
                HStack(spacing: 10) {
                    Menu {
                        Button { } label: { Label("Add to Favorites", systemImage: "heart") }
                        Button { } label: { Label("Show in Maps", systemImage: "mappin") }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                            .font(.system(size: 25, weight: .semibold))
                            .frame(width: 57, height: 57)
                            
                            .foregroundColor(.primary)
                            .background(Color(hex: "#1c1c1e"), in: RoundedRectangle(cornerRadius: 36, style: .continuous))
                    }

                    HStack {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 20, weight: .medium))
                        TextField("Пошук", text: $text)
                            .font(.title3.bold())
                            .frame(height: 44)
                    }
                    .padding(.horizontal, 12)
                    .frame(height: 57)
                    .background(Color(hex: "#1c1c1e"), in: RoundedRectangle(cornerRadius: 36, style: .continuous))

                    Button(action: { modal = true }) {
                        Image(systemName: "square.and.pencil")
                            .font(.system(size: 25, weight: .semibold))
                            .frame(width: 57, height: 57)
                    }
                    .foregroundColor(.primary)
                    .background(Color(hex: "#1c1c1e"), in: RoundedRectangle(cornerRadius: 36, style: .continuous))
                }
                .padding()
            }
        }
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                ScrollView {
                    VStack(spacing: 12) {
                        HStack {
                            VStack(alignment:.leading) {
                                Menu {
                                    Button { selectedFilter = 0 } label: { Label("Вхідні", systemImage: "tray") }
                                    Button { selectedFilter = 1 } label: { Label(selectedFilter==1 ? "Вхідні":"Вихідні", systemImage: "paperplane") }
                                } label: {
                                    Text(filters[selectedFilter])
                                        .font(.title)
                                        .bold()
                                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                                }
                                Text("Оновлено щойно")
                                    .font(Font.headline)
                                    .foregroundColor(Color(.secondaryLabel))
                            }
                            Spacer()
                        }
                        .headerVisibility(hidden: $headerHidden, threshold: 0)
                        .padding(.horizontal, 16)
                        .padding(.top, 12)

                        Divider()
                            .padding(.leading, 16)

                        LazyVStack(spacing: 0) {
                            ForEach(messages) { msg in
                                NavigationLink(destination: MessageModal(message: msg)) {
                                    MessageRow(message: msg)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }
                .padding(.bottom, 22)

                Rectangle()
                       .fill(.clear)
                       .frame(height: 90)
                       .contentShape(Rectangle())
                       .allowsHitTesting(true)
                       .zIndex(1)

                BottomView(modal:$modal)
                       .zIndex(2)

                StikyHeadView(headerHidden: headerHidden, Title: filters[selectedFilter])
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .sheet(isPresented: $modal) {
                SendMessage()
            }
        }
    }
}

// MARK: - Message Row
struct MessageRow: View {
    let message: Message
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        HStack(alignment: .top, spacing: 8) {

            // dot
            VStack {
                if !message.isRead {
                    LinearGradient(
                        colors: [
                            Color(red: 0.20, green: 0.56, blue: 0.93),
                            Color(red: 0.16, green: 0.52, blue: 0.88)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(width: 9, height: 9)
                    .clipShape(Circle())
                }
            }
            .frame(width: 16)
            .padding(.top, 22)

            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 6) {
                    Text(message.sender)
                        .font(.system(size: 16, weight: .bold))
                        .lineLimit(1)
                    Spacer()
                    HStack(spacing: 2) {
                        Text(message.date)
                            .font(.system(size: 13))
                            .foregroundStyle(.secondary)
                        Image(systemName: "chevron.forward")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(colorScheme == .dark
                                             ? .white.opacity(0.35)
                                             : .black.opacity(0.25))
                    }
                }
                Text(message.topic)
                    .font(.system(size: 14, weight: .semibold))
                Text(message.pred)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color(.secondaryLabel))
            }
            .padding(.top, 16)
            .padding(.bottom, 16)
            .padding(.trailing, 16)
        }
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(colorScheme == .dark
                      ? Color.white.opacity(0.12)
                      : Color.black.opacity(0.10))
                .frame(height: 0.8)
                .padding(.leading, 18)
        }
    }
}

// MARK: - Preview
#Preview {
    MessagesScreen()
}
