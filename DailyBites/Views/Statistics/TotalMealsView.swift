//
//  TotalMealsView.swift
//  DailyBites
//
//  Created by Lucas Ibiapina on 08/06/26.
//

import SwiftUI
import SwiftData
import Charts

struct TotalMealsView: View {
    
    @Query(sort: \LogMeal.date, order: .forward) var logs: [LogMeal]
    
    
    @Environment(\.dismiss) private var dismiss

    
    var body: some View {
        
        NavigationStack{
            ScrollView{
                VStack{
                    VStack{
                        VStack{
                            Text("\(getEatenMeals())")
                                .padding(10)
                                .font(Font.system(size: 100, weight: .black, design: .default))
                                .foregroundStyle(Color("RoxoAcao"))
                                }
                            
                            Spacer()
                            
                            Text("Refeições")
                                .font(.title2)
                        }
                        .padding(20)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        
                        
                    StatisticCardView(statistic: .totalDerefeicoes)
                    }
                }
                .padding(10)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction ) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                    ToolbarItem(placement: .title){
                        Text("Tempo das refeições")
                    }
                }
                
                .background(Color(.secondarySystemBackground))

            }

            
        }
    
    func getEatenMeals() -> Int {
        
        let count = logs.count { meal in
            return (meal.status == .pontual || meal.status == .atrasado)
        }
        
        return count
    }
    }

#Preview {
    TotalMealsView()
}
