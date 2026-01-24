import SwiftUI

struct EditWidgetsModal: View {
    
    @Binding var isPresented: Bool
    @Binding var widgets: [Widgetd]  // теперь привязка к родителю
    @State private var isEditing: Bool = true
    
    var body: some View {
        NavigationStack {
            Divider()
            
            List {
                ForEach(widgets) { item in
                    HStack {
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
                    widgets.move(fromOffsets: indices, toOffset: newOffset)
                }
                .moveDisabled(!isEditing)
            }
            .listStyle(.sidebar)
            .environment(\.editMode, .constant(isEditing ? EditMode.active : EditMode.inactive))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Закріплені")
                        .font(.system(size: 22, weight: .bold))
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isPresented = false }) {
                        Image(systemName: "checkmark")
                            .foregroundStyle(.white)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color.blue.mix(with: .white, by: 0.1))
                }
            }
        }
        .presentationDetents([.large])
        .cornerRadius(20)
    }
}
