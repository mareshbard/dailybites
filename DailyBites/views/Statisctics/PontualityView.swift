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

    @Environment(\.dynamicTypeSize) private var dynamicTypeSize: DynamicTypeSize
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
            List {
                VStack{
                    
                    ViewThatFits{
                        HStack{
                            Chart {
                                ForEach(
                                    status.filter({$0.status != .pendente})
                                ) { status in
                                    SectorMark(
                                        angle: .value("Status", status.count),
                                        innerRadius: .ratio(0.05),
                                        outerRadius: .ratio(0.9),
                                        angularInset: 1
                                    )
                                    .foregroundStyle(by: .value("name", status.status.title))
                                    .foregroundStyle(Color.red)
                                }
                            }.chartLegend(position: dynamicTypeSize.isAccessibilitySize ? .bottomLeading : .trailing, alignment: .center) {

                                VStack(alignment: .leading){

                                    HStack() {
                                        Color("VerdeDailyBites").frame(width: 20, height: 20).cornerRadius(5)
                                        Text("Realizada pontualmente")
                                            .foregroundStyle(Color.primary)
                                    }
                                    
                                    HStack {
                                        Color("AmareloDailyBites").frame(width: 20, height: 20).cornerRadius(5)
                                        Text("Realizada com atraso")
                                            .foregroundStyle(Color.primary)
                                    }
                                    
                                    HStack {
                                        Color("VermelhoDailyBites").frame(width: 20, height: 20).cornerRadius(5)
                                        Text("Não realizou")
                                            .foregroundStyle(Color.primary)
                                    }

                                }
                            }
                            .chartForegroundStyleScale([
                                Status.atrasado.title: Color("AmareloDailyBites"),
                                Status.pontual.title: Color("VerdeDailyBites"),
                                Status.pulou.title: Color("VermelhoDailyBites")
                            ])
                        }
                        .padding(.horizontal, 10)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)
                        .frame(maxWidth: .infinity)
                        
                        VStack{
                            Chart {
                                ForEach(
                                    status.filter({$0.status != .pendente})
                                ) { status in
                                    SectorMark(
                                        angle: .value("Status", status.count),
                                        innerRadius: .ratio(0.05),
                                        outerRadius: .ratio(0.9),
                                        angularInset: 1
                                    )
                                    .foregroundStyle(by: .value("name", status.status.title))
                                    .foregroundStyle(Color.red)
                                }
                            }.chartLegend(position: dynamicTypeSize.isAccessibilitySize ? .bottomLeading : .trailing, alignment: .center) {

                                VStack(alignment: .leading){

                                    HStack() {
                                        Color("VerdeDailyBites").frame(width: 20, height: 20).cornerRadius(5)
                                        Text("Realizada pontualmente")
                                            .foregroundStyle(Color.primary)
                                    }
                                    
                                    HStack {
                                        Color("AmareloDailyBites").frame(width: 20, height: 20).cornerRadius(5)
                                        Text("Realizada com atraso")
                                            .foregroundStyle(Color.primary)
                                    }
                                    
                                    HStack {
                                        Color("VermelhoDailyBites").frame(width: 20, height: 20).cornerRadius(5)
                                        Text("Não realizou")
                                            .foregroundStyle(Color.primary)
                                    }

                                }
                            }
                            .chartForegroundStyleScale([
                                Status.atrasado.title: Color("AmareloDailyBites"),
                                Status.pontual.title: Color("VerdeDailyBites"),
                                Status.pulou.title: Color("VermelhoDailyBites")
                            ])
                        }
                        .padding(.horizontal, 10)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)
                        .frame(maxWidth: .infinity)
                    }
                    
                    
                    VStack {
                        Text("O que a pontualidade diz sobre sua alimentação?")
                            .font(.title2.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            
                            Text("Segundo o Ministério da Saúde, manter a pontualidade e a regularidade nas refeições equilibra os sinais de fome e saciedade. Essa rotina evita excessos e o consumo de ultraprocessados, sendo essencial para o bom funcionamento do metabolismo.")
                            
                            Image("pineappleGlass")
                                .frame(width: 100, height: 100)
                                .padding(10)
                                
                            
                        }
                        
                    }
                    .padding(10)
                    .background(Color.gray.opacity(0.1))
                    
                    
                }
                .listRowSeparator(.hidden)
            }

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
        
        .listStyle(.plain)
        
        
        
    }
}

#Preview {
    PontualityView()
}
