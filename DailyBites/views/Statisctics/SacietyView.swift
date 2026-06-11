//
//  SacietyView.swift
//  DailyBites
//
//  Created by Lucas Ibiapina on 08/06/26.
//

import SwiftUI
import SwiftData

struct SacietyView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Query(sort: \LogMeal.date, order: .forward) var logs: [LogMeal]
    
//    var percentage: [Double]{
//        
//        var result: [Double] = []
//        for satiety in Satiety.allCases {
//            let filtered_meals: [LogMeal] = logs.filter({$0.status != .pendente && $0.status != .pulou})
//            let filtered: [LogMeal] = filtered_meals.filter({$0.saciedade == satiety})
//            let total: Double = Double(filtered_meals.count)
//            let totalMood: Double = Double(filtered.count)
//            if(total == 0){
//                result.append(0)
//            } else {
//                result.append(totalMood/total * 100) // filtra e verifica todas as moods e faz o calculo de porcentagem
//            }
//        }
//        return result
//    }
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    
                    VStack{
                        
    //                    HStack {
    //
    //                        ForEach(percentage, id: \.self){ percentage in
    //                            Text("\(String(format: "%.0f", percentage))%")
    //                        } //mostra as porcentagens
    //                        .padding(10)
    //                        .font(.body)
    //
    //                    }

                        
                        HStack {
                            
                            ForEach(Satiety.allCases, id: \.self){ mood in
                                Text(mood.rawValue)//mostra a legenda dos moods
                                    //.background(Color.Satiety.allCases[mood].backgroundSatiety)
                            }
                            .padding(10)
                            .font(.subheadline)
                            .background(Color.yellow)
                            .clipShape(RoundedRectangle(cornerRadius: 12))

                
                        }

                        

                        
                    }
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.1))

                    VStack {
                        Text("O que o nível de saciedade indica?")
                            .font(.title2.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("Acompanhar como você termina cada refeição revela se está comendo na quantidade certa.  Seu nível de saciedade  após cada refeição ajuda a identificar padrões e ajustar as refeições para sentir mais equilíbrio no dia a dia.")
                    }
                    .padding(10)
                    .background(Color.gray.opacity(0.1))

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
                        Text("Saciedade")
                    }
                }
            }
        }
        
    }
}

#Preview {
    SacietyView()
}
