//
//  ChartsView.swift
//  Tvoia
//
//  Created by Maxim Loza on 22.01.2026.
//

import SwiftUI
import Charts
struct ChartsView: View {
    
    struct Item: Identifiable {
        let id = UUID()
        let name: String
        let value: Int
        let color: Color
    }
    
    let data: [Item] 
    
    var body: some View {
        VStack(alignment: .leading) {

            Chart(data) { item in
                BarMark(
                    x: .value("Day", item.name),
                    y: .value("Value", item.value)
                )
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .foregroundStyle(item.color)
            }
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            .chartLegend(.hidden)
            .frame(height: 60)
            .frame(width: 80)
            .offset(y: 10)
            
            
        }
        .padding()
    }
}




