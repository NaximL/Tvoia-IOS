//
//  HomeView.swift
//  Tvoia
//
//  Created by Maxim Loza on 21.01.2026.
//

import SwiftUI

struct HomeView: View {
    
    struct Widgetd: Identifiable {
        let id = UUID()
        let icon: String
        let title: String
        let time: String
        let color: Color
        let content: AnyView
    }

    let widgets: [Widgetd] = [
        Widgetd(
            icon: "star.fill",
            title: "Виджет 1",
            time: "12:00",
            color: .blue,
            content: AnyView(
                Text("Привет мир!")
            )
        ),
        Widgetd(
            icon: "heart.fill",
            title: "Виджет 2",
            time: "15:30",
            color: .red,
            content: AnyView(
                HStack {
                    Image(systemName: "heart")
                    Text("Люблю SwiftUI")
                }
            )
        ),
        Widgetd(
            icon: "bolt.fill",
            title: "Виджет 3",
            time: "18:45",
            color: .yellow,
            content: AnyView(
                VStack {
                    Text("Еще один виджет")
                    Image(systemName: "bolt")
                }
            )
        )
    ]
    
    struct FlatList: View {
        let items = Array(1...100)

        var body: some View {
            ZStack {
//                Color.black
//                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(widgets) { item in
                            WidgetView(item: item)
                        }
                    }
                    .padding()
                }
            }
        }
    }
    var body: some View {
        FlatList()
    }
}


#Preview {
    HomeView()
}
