import SwiftUI


struct EditWidgetsModal: View {
    
    @Binding var isPresented: Bool
    @State private var widgets: [Widgetd]
    @State private var isEditing: Bool = false
    
    init(isPresented: Binding<Bool>, widgets: [Widgetd]) {
        self._isPresented = isPresented
        self._widgets = State(initialValue: widgets)
    }
    
    var body: some View {
        ZStack {
            // Liquid glass фон
            VisualEffectView(material: .ultraThin)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Заголовок
                HStack {
                    Text("Закріплені")
                        .font(.title2.bold())
                    
                    Spacer()
                    
                    Button(action: {
                        if isEditing {
                            isEditing = false
                        } else {
                            isPresented = false
                        }
                    }) {
                        Text(isEditing ? "Готово" : "Закрити")
                            .bold()
                    }
                    
                    Button(action: {
                        isEditing.toggle()
                    }) {
                        Text(isEditing ? "Готово" : "Редагувати")
                            .bold()
                            .padding(.leading, 8)
                    }
                }
                .padding()
                
                Divider()
                
                // Список с drag & drop
                List {
                    ForEach(widgets) { item in
                        HStack {
                            if isEditing {
                                Image(systemName: "line.3.horizontal")
                                    .foregroundColor(.gray)
                            }
                            
                            Image(systemName: item.icon)
                                .foregroundColor(item.color)
                            Text(item.title)
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(item.color.mix(with: .black, by: 0.1))
                            Spacer()
                        }
                        .padding(.vertical, 8)
                    }
                    .onMove { indices, newOffset in
                        if isEditing {
                            widgets.move(fromOffsets: indices, toOffset: newOffset)
                        }
                    }
                    .moveDisabled(!isEditing)
                }
                .listStyle(.plain)
                .environment(\.editMode, .constant(isEditing ? EditMode.active : EditMode.inactive))
            }
        }
        .presentationDetents([.medium, .large])
        .cornerRadius(20)
    }
}

// UIKit bridge для liquid glass
struct VisualEffectView: UIViewRepresentable {
    var material: UIBlurEffect.Style = .systemUltraThinMaterial
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: material))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
