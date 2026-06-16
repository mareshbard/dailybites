//
//  DurationMealView.swift
//  DailyBites
//
//  Created by Lucas Ibiapina on 08/06/26.
//

import SwiftUI
import SwiftData
import Charts

struct DurationMealView: View {
    
    @Query(sort: \LogMeal.date, order: .forward) var logs: [LogMeal]
    @State var media: Int = 0
    @State var total: Int = 0
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        let todayMeals = logs.filter {$0.status != .pendente && $0.status != .pulou}
       
        let total = todayMeals.reduce(0) {$0 + $1.durationMeal}
        let media = getAverage(total: total, count: todayMeals.count)
        
        NavigationStack{
            ScrollView{
                VStack{
                    VStack{
                        Text("\(media)")
                            .padding(70)
                            .font(Font.system(size: 70, weight: .black, design: .default))
                            .clipShape(Circle())
                            .overlay{
                                Circle().stroke(Color("RoxoAcao"), style: StrokeStyle(lineWidth: 30))
                            }
                        
                        Spacer()
                        
                        Text("Minutos")
                            .font(.title2)
                            .padding(10)
                    }
                    .padding(30)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color("BackgroundCard"))
                    .cornerRadius(12)
                    
                    
                        VStack {
                            StatisticCardView(statistic: .tempoDasrefeicoes)
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
                }
                .background(Color.backgroundCor)
            }
            

            
        }
    }
    
    private func getAverage(total: Int, count: Int)->Int{
        if total == 0{
            return 0
        } else {
            return Int(total/count)
        }
    }

#Preview {
    DurationMealView()
}
