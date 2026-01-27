//
//  HeaderView.swift
//  Tvoia
//
//  Created by Maxim Loza on 23.01.2026.
//

import SwiftUI



struct HeaderView: View {
    @State private var showModalEdit = false
    @Binding var widgets: [Widgetd]
    
    var body: some View {
        
        VStack(spacing: 40) {
            
            
            HStack(alignment:.center) {
                    Text("Статистика")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)

                    
                    Spacer()
                    
                    Image("Avatar")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                .padding(.horizontal)
            
            
            HStack(alignment: .center) {
                Text("Закріплені")
                    .font(.system(size: 26))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    
                    
                Spacer();
                
                if #available(iOS 26.0, *) {
                    Button(action: {
                        showModalEdit=true
                    }){
                        Text("Змінити")
                            .font(.system(size: 18, weight: .bold))
                            .padding(.all,11)
                            .foregroundColor(.white)
                    }
                    .sheet(isPresented: $showModalEdit) {
                        EditWidgetsModal(isPresented: $showModalEdit, widgets: $widgets)
                    }
                    
                    .glassEffect(.clear.interactive())
                }
                else {
                    Button(action: {
                        showModalEdit=true
                    }){
                        Text("Змінити")
                            .font(.system(size: 18, weight: .bold))
                            .padding(.all,11)
                            .foregroundColor(.white)
                    }
                    .sheet(isPresented: $showModalEdit) {
                        EditWidgetsModal(isPresented: $showModalEdit, widgets: $widgets)
                    }
                    .padding(3)
                    
                    
                    
                    .background(Color(hex: "#1c1c1e"))
                    .cornerRadius(.infinity)
                    .overlay {
                        RoundedRectangle(cornerRadius: 36)
                            .stroke(
                                LinearGradient(
                                    colors: [
                                        .white.opacity(0.8),
                                        .white.opacity(0.15),
                                        .clear,
                                        .white.opacity(0.7),
                                        .white.opacity(0.7)
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1.5
                            )
                            .blur(radius: 0.6)
                            .blendMode(.overlay)
                    }
                }
                
            }.padding(.horizontal)
        }
    }
}

