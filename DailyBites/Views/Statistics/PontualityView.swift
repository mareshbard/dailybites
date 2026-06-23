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
                
                VStack(alignment: .leading){
                    
                    ViewThatFits{
                        
                        HStack{
                            chartView
                            chartLegend
                        }
                        .padding(.top, 15)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        
                        VStack{
                            chartView
                            chartLegend
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                    }
                    
                    StatisticCardView(statistic: .pontualidade)
                    
                }
                .padding(.horizontal)
                
            }
            .frame(maxHeight:.infinity)
            .padding(.top, -50)
            .background(Color(.secondarySystemBackground))
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
        ZStack{
            VStack {
                ForEach(status.filter { $0.status == .pontual }) { item in
                        Text("\(String(format: "%.0f", percentage(for: item.status)))%")
                        .font(Font.custom("PlusJakartaSans-Semibold", size: 24))
                        .bold(true)
                        .foregroundStyle(Color.roxoAcao)
                            
                    }
                Text("no horário")
                    .font(Font.custom("PlusJakartaSans", size: 16))
                    .foregroundStyle(Color.primary)
            }
            
            Chart {
                ForEach(
                    status.filter({$0.status != .pendente})
                ) { status in
                    SectorMark(
                        angle: .value("Status", status.count),
                        innerRadius: .ratio(0.8),
                        outerRadius: .ratio(0.9),
                        angularInset: 1)
                    .foregroundStyle(by: .value("name", status.status.title))
                }
            }
            
            //        .frame(minWidth: 100, maxWidth: 200, minHeight: 100, maxHeight: 200)
            .accessibilityLabel(Text("Gráfico de Pontualidade"))
            .chartLegend(.hidden)
            .chartForegroundStyleScale([
                Status.atrasado.title: Color("LaranjaAtrasado"),
                Status.pontual.title: Color("RoxoAcao"),
                Status.pulou.title: Color("Pulou")
            ])
            .scaledToFit()
        }
       
    }
    
    func percentage(for status: Status) -> Double {
        let completedLogs = logs.filter { $0.status != .pendente }
        let total = Double(completedLogs.count)
        let statusTotal = Double(completedLogs.filter { $0.status == status }.count)
        
        guard total > 0 else { return 0 }
        return statusTotal / total * 100
    }
    
    func legendColor(for status: Status) -> Color {
        switch status {
        case .pontual:
            return Color("RoxoAcao")
        case .atrasado:
            return Color("LaranjaAtrasado")
        case .pulou:
            return Color("Pulou")
        case .pendente:
            return .clear
        }
    }
    
    func legendTitle(for status: Status) -> String {
        switch status {
        case .pontual:
            return "Realizada no horário"
        case .atrasado:
            return "Realizada com atraso"
        case .pulou:
            return "Não realizada"
        case .pendente:
            return "Pendente"
        }
    }
    
    var chartLegend: some View {
        VStack(alignment: .leading) {
            ForEach(status.filter { $0.status != .pendente }) { item in
                HStack {
                    legendColor(for: item.status)
                        .frame(width: 20, height: 20)
                        .cornerRadius(5)
                    
                    Text("\(legendTitle(for: item.status)) \(String(format: "(%.0f", percentage(for: item.status)))%)")
                        .foregroundStyle(Color.primary)
                        .font(.subheadline)
                }
                .padding(.horizontal, 10)
            }
        }
        .accessibilityHidden(true)
    }
}

#Preview {
    PontualityView()
}
