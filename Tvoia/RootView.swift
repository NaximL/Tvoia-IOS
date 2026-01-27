
//
//  RootView.swift
//  Tvoia
//
//  Created by Maxim Loza on 21.01.2026.
//



import SwiftUI

struct RootView: View {
   @State private var isLogin = true
   var body: some View {
       
           if isLogin {
               NavigationStack {
               TabView {
                   Tab("Statisitc", systemImage: "house") {
                       HomeView()
                   }
                   Tab("Letters", systemImage: "envelope") {
                       MessagesScreen()
                   }
                   Tab("HomeWork", systemImage: "doc.text") {
                       HomeView()
                   }
                   Tab("Schedule", systemImage: "calendar") {
                       HomeView()
                   }
               }
               }
           }
           else {
               LoginView()
           }
       
   }
}

#Preview {
   RootView()
}
