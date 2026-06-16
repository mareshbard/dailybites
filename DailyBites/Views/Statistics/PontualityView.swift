//
//  PontualityView.swift
//  DailyBites
//
//  Created by Lucas Ibiapina on 04/06/26.
//

import SwiftUI
import SwiftData
import Charts

struct StatusMeal: Identifiable {
    let id = UUID()
    var status: Status
    var count: Int
}

struct PontualityView: View {
    
    @State private var isShowingSheet: Bool = false

    @Environment(\.dismiss) private var dismiss
    
    @Query(sort: \LogMeal.date, order: .forward) var logs: [LogMeal]
    
    var status: [StatusMeal] {
        var result: [StatusMeal] = []
        for status in Status.allCases {
            let filtered: [LogMeal] = logs.filter({$0.status == status})
            let count = filtered.count
            result.append(StatusMeal(status: status, count: count))
            
        }
        return result
    }
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack{
                    ViewThatFits{
                        HStack{
                            chartView
                            chartLegend
                        }
                        .padding(10)
                        .background(Color("BackgroundCard"))
                        .cornerRadius(12)
                        .frame(maxWidth: .infinity)
                        
                        VStack{
                            chartView
                            chartLegend
                        }
                        .padding(.horizontal, 10)
                        .background(Color("BackgroundCard"))
                        .cornerRadius(12)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    
                    StatisticCardView(statistic: .pontualidade)
                    
                }
                .padding(10)
                    
            }
            .background(Color.backgroundCor)
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .cancellationAction ) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                
                ToolbarItem(placement: .title){
                    Text("Pontualidade")
                }
            }
        }
    }
    
    var chartView: some View {
        Chart {
            ForEach(
                status.filter({$0.status != .pendente})
            ) { status in
                SectorMark(
                    angle: .value("Status", status.count),
                    innerRadius: .ratio(0.7),
                    outerRadius: .ratio(0.9),
                    angularInset: 1
                )
                .foregroundStyle(by: .value("name", status.status.title))
                .foregroundStyle(Color.red)
            }
        }
        .chartLegend(.hidden)
        .chartForegroundStyleScale([
            Status.atrasado.title: Color("LaranjaAtrasado"),
            Status.pontual.title: Color("RoxoAcao"),
            Status.pulou.title: Color("Pulou")
        ])
        .scaledToFit()
    }
    
    var chartLegend: some View {
        VStack(alignment: .leading){
            HStack() {
                Color("RoxoAcao").frame(width: 20, height: 20).cornerRadius(5)
                Text("Realizada pontualmente")
                    .foregroundStyle(Color.primary)
                    
            }
            
            HStack {
                Color("LaranjaAtrasado").frame(width: 20, height: 20).cornerRadius(5)
                Text("Realizada com atraso")
                    .foregroundStyle(Color.primary)
            }
            
            HStack {
                Color("Pulou").frame(width: 20, height: 20).cornerRadius(5)
                Text("Não realizou")
                    .foregroundStyle(Color.primary)
            }
        }
    }
}

#Preview {
    PontualityView()
}
