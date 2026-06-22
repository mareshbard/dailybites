//
//  QuantityMealsView.swift
//  DailyBites
//
//  Created by Lucas Ibiapina on 07/06/26.
//

import SwiftUI
import SwiftData
import Charts

struct QuantityMealsView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Query(sort: \LogMeal.date, order: .forward) var logs: [LogMeal]
    @Query var meals: [Meal] = []
    @AppStorage("numberOfMeals") private var numberOfMeals: Int = 1
    
    @State private var countMealSunday: Int = 0
    
    @Environment(\.dynamicTypeSize)
    private var isAccessible: DynamicTypeSize
    
    enum Semana: String, CaseIterable, Codable {
        
        case Dom = "Dom"
        case Seg = "Seg"
        case Ter = "Ter"
        case Qua = "Qua"
        case Qui = "Qui"
        case Sex = "Sex"
        case Sab = "Sáb"
        
        
        var weekday: Int {
            switch self {
            case .Dom:
                1
            case .Seg:
                2
            case .Ter:
                3
            case .Qua:
                4
            case .Qui:
                5
            case .Sex:
                6
            case .Sab:
                7
            }
        }
        
    }
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    VStack{
                        Text("Quantidade de refeições")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Chart{
                                ForEach(Semana.allCases, id: \.self){ dia in
                                    
                                    if isAccessible.isAccessibilitySize {
                                        BarMark(
                                            x: .value("Refeicoes",
                                                      getEatenMealsFromWeekday(dia)
                                                     ),
                                            y: .value("Dias", dia.rawValue)
                                        )
                                        
                                        .foregroundStyle(Color("RoxoAcao"))
                                        .clipShape(RoundedRectangle(cornerRadius: 32))
                                    } else {
                                        BarMark(
                                            x: .value("Dias", dia.rawValue),
                                            y: .value("Refeicoes",
                                                      getEatenMealsFromWeekday(dia)
                                                     )
                                        )
                                        .foregroundStyle(Color("RoxoAcao"))
                                        .clipShape(RoundedRectangle(cornerRadius: 32))
                                    }
                                    

                                }
                                
                            }
                            .scaledToFit()
                            .chartYAxis{
                                AxisMarks(position: .leading, stroke: StrokeStyle(lineWidth: 0))
                            }
                            .chartXAxis{
                                AxisMarks(stroke: StrokeStyle(lineWidth: 0))
                            }
                        
                        
                        
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding(10)
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    
                    
                    StatisticCardView(statistic: .resistroSemanal)
                }
                .padding(.horizontal, 20)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction ) {
                        
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                    
                    ToolbarItem(placement: .title){
                        Text("Registro semanal")
                    }
                }
            }
            .background(Color(.secondarySystemBackground))

        }
        
        
            
    }
    
    func getEatenMealsFromWeekday(_ day: Semana) -> Int {
        
        let count = logs.count { meal in
            let weekday = Calendar.current.component(.weekday, from: meal.date)
            return (meal.status == .pontual || meal.status == .atrasado) && weekday == day.weekday
        }
        
        return count
    }
}

#Preview {
    QuantityMealsView()
}
