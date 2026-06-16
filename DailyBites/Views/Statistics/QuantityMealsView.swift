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
                                BarMark(
                                    x: .value("Dias", dia.rawValue),
                                    y: .value("Refeicoes",
                                              getEatenMealsFromWeekday(dia)
            //                                              Int.random(in: 0...numberOfMeals)
                                             )
                                )
                                .foregroundStyle(Color("CordeAção"))
                                .clipShape(RoundedRectangle(cornerRadius: 32))
                                
                                
                            }
                            
                        }
                        .chartYAxis{
                            AxisMarks(position: .leading, stroke: StrokeStyle(lineWidth: 0))
                        }
                        .chartXAxis{
                            AxisMarks(stroke: StrokeStyle(lineWidth: 0))
                        }
                        //   .AxisGridLine(.hidden)
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding(10)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    
                    VStack {
                        Text("O que o registro semanal mostra?")
                            .font(.title2.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("Visualizar sua constância ao longo da semana é o primeiro passo para criar uma rotina alimentar sustentável. A regularidade é tão importante quanto a qualidade do que se come.")
                    }
                    .padding(10)
                    .background(Color.gray.opacity(0.1))
                }
                .padding(20)
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
