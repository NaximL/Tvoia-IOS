import SwiftUI

// MARK: - Модель
struct HomeworkItem: Identifiable {
    let id = UUID()
    let subject: String
    let description: String?
    let assignedDate: Date?
    let dueDate: Date?
}

struct HomeworkSection: Identifiable {
    let id = UUID()
    let title: String
    let items: [HomeworkItem]
}

// MARK: - Главный экран
struct HomeWorkView: View {
    @State private var sections: [HomeworkSection] = []
    @State private var loading = true
    @State private var selectedItem: HomeworkItem? = nil
    @State private var showModal = false
    @State private var animateCards: Bool = false
    
    var body: some View {
        ZStack {
            // Фон
            LinearGradient(colors: [Color("BackgroundTop"), Color("BackgroundBottom")],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            if loading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
            } else {
                ScrollView {
                    LazyVStack(spacing: 20, pinnedViews: []) {
                        ForEach(sections) { section in
                            VStack(alignment: .leading, spacing: 12) {
                                Text(section.title)
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                
                                if section.items.isEmpty {
                                    Text("Немає домашнього завдання 😴")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .padding(.vertical, 20)
                                } else {
                                    Group {
                                                ForEach(Array(section.items.enumerated()), id: \.1.id) { index, item in
                                                    HomeworkCard(item: item)
                                                        .opacity(animateCards ? 1 : 0)
                                                        .offset(y: animateCards ? 0 : 20)
                                                        .animation(.easeOut.delay(Double(index) * 0.1), value: animateCards)
                                                        .onTapGesture {
                                                            selectedItem = item
                                                            showModal = true
                                                        }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.vertical, 30)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 100)
                }
            }
        }
        .task {
            await fetchHomework()
            withAnimation {
                animateCards = true
            }
        }
        .sheet(isPresented: $showModal) {
            if let selectedItem {
                HomeworkDetailView(item: selectedItem)
            }
        }
    }
    
    // MARK: - Загрузка данных (пример)
    func fetchHomework() async {
        try? await Task.sleep(nanoseconds: 800_000_000)
        
        let today = Date()
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
        let dayAfter = Calendar.current.date(byAdding: .day, value: 2, to: today)!
        
        sections = [
            HomeworkSection(title: "Сьогодні (\(formatDate(today)))", items: [
                HomeworkItem(subject: "Математика", description: "Розв'язати вправи 1-10", assignedDate: today, dueDate: tomorrow),
                HomeworkItem(subject: "Українська мова", description: "Написати есе", assignedDate: today, dueDate: tomorrow)
            ]),
            HomeworkSection(title: "Завтра (\(formatDate(tomorrow)))", items: [
                HomeworkItem(subject: "Фізика", description: "Лабораторна робота", assignedDate: today, dueDate: dayAfter)
            ]),
            HomeworkSection(title: "Післязавтра (\(formatDate(dayAfter)))", items: [])
        ]
        
        loading = false
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

// MARK: - Карточка домашки
struct HomeworkCard: View {
    let item: HomeworkItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(item.subject)
                .font(.title3.weight(.semibold))
                .foregroundStyle(.primary)

            if let desc = item.description {
                Text(desc)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .lineLimit(3)
            }

            HStack(spacing: 14) {
                if let assigned = item.assignedDate {
                    Label("Задано: \(formatDate(assigned))", systemImage: "calendar.badge.plus")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                if let due = item.dueDate {
                    Label("До: \(formatDate(due))", systemImage: "clock")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .glassCard(cornerRadius: 28)
        .overlay(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .strokeBorder(.white.opacity(0.15), lineWidth: 1)
                .blendMode(.overlay)
        )
        .shadow(color: Color.black.opacity(0.12), radius: 20, x: 0, y: 12)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 1)
        .contentShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}

private extension View {
    @ViewBuilder
    func glassCard(cornerRadius: CGFloat = 28) -> some View {
        if #available(iOS 26.0, *) {
            self
                .glassEffect(
                    .regular
                        .tint(.white.opacity(0.08))
                        .interactive(),
                    in: .rect(cornerRadius: cornerRadius)
                )
        } else {
            self
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        }
    }
}

// MARK: - Модальное окно с деталями
struct HomeworkDetailView: View {
    let item: HomeworkItem
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(item.subject)
                    .font(.largeTitle.bold())
                
                if let assigned = item.assignedDate {
                    Text("Задано: \(formatDate(assigned))")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                if let due = item.dueDate {
                    Text("До: \(formatDate(due))")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                if let desc = item.description {
                    Text(desc)
                        .font(.body)
                } else {
                    Text("Немає опису")
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            .padding()
        }
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
}

// MARK: - Preview
struct HomeWorkView_Previews: PreviewProvider {
    static var previews: some View {
        HomeWorkView()
            .preferredColorScheme(.light)
        HomeWorkView()
            .preferredColorScheme(.dark)
    }
}

