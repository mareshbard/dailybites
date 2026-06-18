//
//  MoodbarView.swift
//  DailyBites
//
//  Created by Lucas Ibiapina on 07/06/26.
//

import SwiftUI
import SwiftData
//fhdgfdnf
struct MoodbarView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Query(sort: \LogMeal.date, order: .forward) var logs: [LogMeal]
    
    var percentage: [Double]{
        var result: [Double] = []
        for mood in Mood.allCases {
            let filtered_meals: [LogMeal] = logs.filter({$0.status != .pendente && $0.status != .pulou})
            let filtered: [LogMeal] = filtered_meals.filter({$0.emotion == mood})
            let total: Double = Double(filtered_meals.count)
            let totalMood: Double = Double(filtered.count)
            if(total == 0){
                result.append(0)
            } else {
                result.append(totalMood/total * 100) // filtra e verifica todas as moods e faz o calculo de porcentagem
            }
        }
        return result
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack{
                    
                    ViewThatFits{
                        
                        HStack {
                            ForEach(Mood.allCases.indices, id: \.self) { index in
                                let mood = Mood.allCases[index]
                                
                                VStack(spacing: 10) {
                                    mood.content
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 50)
                                    
                                    Text(MoodDescription.allCases[index].rawValue)
                                        .font(.headline)
                                    
                                    Text(
                                        "\(String(format: "%.0f", percentage[index]))%"
                                    )
                                    .font(.body)
                                }
                                .padding(10)
                                .background(Color(mood.color))
                                .cornerRadius(12)
                                .frame(maxHeight: .infinity)
                            }
                        }
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .background(Color("BackgroundCard"))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        
                        VStack {
                            ForEach(Mood.allCases.indices, id: \.self) { index in
                                let mood = Mood.allCases[index]
                                
                                HStack(spacing: 10) {
                                    mood.content
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxWidth: 70, maxHeight: 70)
                                        .accessibilityHidden(true)
                                    
                                    Text(MoodDescription.allCases[index].rawValue)
                                        .font(.headline)
                                    
                                    Spacer()
                                    
                                    Text(
                                        "\(String(format: "%.0f", percentage[index]))%"
                                    )
                                    .font(.body)
                                }
                                .padding(10)
                                .background(Color(mood.color))
                                .cornerRadius(12)
                            }
                        }
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .background(Color("BackgroundCard"))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                    }
                    
                    StatisticCardView(statistic: .humor)
                            
                }
                .padding(10)
                .cornerRadius(12)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction ) {
                        
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                    
                    ToolbarItem(placement: .title){
                        Text("Humor")
                    }
                }
            }
            .background(Color.backgroundCor)

        }
        
    }
}

#Preview {
    MoodbarView()
}
