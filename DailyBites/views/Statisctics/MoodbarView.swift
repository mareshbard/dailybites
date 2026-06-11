//
//  MoodbarView.swift
//  DailyBites
//
//  Created by Lucas Ibiapina on 07/06/26.
//

import SwiftUI
import SwiftData

struct MoodbarView: View {
    
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
        ScrollView{
            VStack{
                
                VStack{
                    
                    
                    HStack {
                        
                        
                        ForEach(Mood.allCases, id: \.self){ mood in
                            Text(mood.rawValue)//mostra os Moods
                        }
                        .padding(10)
                        .font(.largeTitle)
                        
                    }
                    
                    HStack {
                        
                        ForEach(MoodDescription.allCases, id: \.self){ mood in
                            Text(mood.rawValue)//mostra a legenda dos moods
                        }
                        .padding(10)
                        .font(.headline)
            
                    }

                    
                    HStack {
                        
                        ForEach(percentage, id: \.self){ percentage in
                            Text("\(String(format: "%.0f", percentage))%")
                        } //mostra as porcentagens
                        .padding(10)
                        .font(.body)
                        
                    }
                    
                }
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.1))

                VStack {
                    Text("O que o seu humor tem a ver com o que você come?")
                        .font(.title2.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Em momentos de estresse ou tristeza, tendemos a buscar comidas reconfortantes, como doces e alimentos ricos em gorduras. Registrar como você se sente em cada refeição ajuda a identificar padrões emocionais antes que virem hábitos.")
                }
                .padding(10)
                .background(Color.gray.opacity(0.1))

            }
            
            .padding(10)
            .cornerRadius(12)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        
    }
}

#Preview {
    MoodbarView()
}
