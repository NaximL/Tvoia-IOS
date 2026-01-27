//
//  HomeView.swift
//  Tvoia
//
//  Created by Maxim Loza on 21.01.2026.
//

import SwiftUI
struct Widgetd: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let time: String
    let color: Color
    let content: AnyView
}

struct HeaderFrameKey: PreferenceKey {
    static var defaultValue: CGRect = .zero

    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
struct HomeView: View {
    
    @State private var headerHidden = false

    
    @State private var widgets: [Widgetd] = [
        Widgetd(
            icon: "star.circle.fill",
            title: "Середній бал",
            time: "12:00",
            color: .red.opacity(0.9),
            content: AnyView(
                HStack() {
                    TitleView(TitleText: "12.00", TitlePostText: "Балів", Size: 34)
                    Spacer()
                    ChartsView(data: [
                        .init(name: "Wed", value: 4, color: Color.gray),
                        .init(name: "Thu", value: 8, color: Color.gray),
                        .init(name: "Fri", value: 5, color: Color.gray),
                        .init(name: "Sat", value: 9, color: Color.red)
                    ])
                }
            )
        ),
        Widgetd(
            icon: "mail.fill",
            title: "Повідомлення",
            time: "15:30",
            color: .blue,
            content: AnyView(
                HStack() {
                    TitleView(TitleText: "1", TitlePostText: "Непрочитаних", Size: 34)
                    Spacer()
                    ListView(Messages: [
                        .init(who: "Якименко", text: "фца"),
                        .init(who: "Лоза", text: "Найкращий")
                    ])
                }
            )
        ),
        Widgetd(
            icon: "trophy.fill",
            title: "Місце в класі",
            time: "18:45",
            color: .green,
            content: AnyView(
                HStack() {
                    TitleView(TitleText: "1 з 32", TitlePostText: "Місце", Size: 34)
                    Spacer()
                    ChartsView(data: [
                        .init(name: "Wed", value: 4, color: Color.gray),
                        .init(name: "Thu", value: 8, color: Color.gray),
                        .init(name: "Fri", value: 5, color: Color.green),
                        .init(name: "Sat", value: 9, color: Color.gray)
                    ])
                }
            )
        ),
        Widgetd(
            icon: "clock.fill",
            title: "Урок зараз",
            time: "18:45",
            color: Color(hex: "#5E5CE6"),
            content: AnyView(
                HStack() {
                    TitleView(TitleText: "Українська мова", TitlePostText: "до 17:00", Size: 28)
                    Spacer()
                    
                }
            )
        )
    ]


    var body: some View {
        ZStack {
            ScrollView {
                
                ZStack {
                    GradientView()
                    .ignoresSafeArea()
                    
                    
                    VStack {
                        VStack(spacing: 12) {
                            HeaderView(widgets: $widgets)
                                .headerVisibility(hidden: $headerHidden, threshold: 0)
                            
                            LazyVStack(spacing: 12) {
                                ForEach(Array(widgets.enumerated()), id: \.1.id) { index, item in
                                    WidgetView(item: item, index: index)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding(.top, 50)
                    }
                    
                }
            }
            StikyHeadView(headerHidden: headerHidden, Title: "Статистика")
        }
    }
}

