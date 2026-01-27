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
            
            if #available(iOS 26.0, *) {
                HStack(alignment: .center) {
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
            }
            
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
                        Text("Змінити").foregroundStyle(.white)
                    }
                    .sheet(isPresented: $showModalEdit) {
                        EditWidgetsModal(isPresented: $showModalEdit, widgets: $widgets)
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                }
                
            }.padding(.horizontal)
        }
    }
}

