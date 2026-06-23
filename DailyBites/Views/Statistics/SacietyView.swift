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
    
    var percentage: [Double] {
        var result: [Double] = []
        for satiety in Satiety.allCases {
            let filtered_meals: [LogMeal] = logs.filter({$0.status != .pendente && $0.status != .pulou})
            let filtered: [LogMeal] = filtered_meals.filter({$0.satiety == satiety})
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
    
    /// 
    var body: some View {
        
        
        NavigationStack{
            ScrollView{
                VStack{
                    
                    VStack{
                        GeometryReader { geometry in
                            HStack(spacing: 0) {
                                ForEach(
                                    Satiety.allCases.indices.dropFirst(),
                                    id: \.self
                                ){ index in
                                    if percentage[index] > 0 {
                                        ZStack {
                                            Satiety.allCases[index].color
                                            Text(
                                                "\(String(format: "%.0f", percentage[index]))%"
                                            )
                                            .accessibilityLabel(Text("\(Satiety.allCases[index].title)"))
                                            .font(.subheadline)
                                            .padding()
                                            
                                        }
                                        .frame(
                                            width: generateWidth(
                                                for: percentage[index],
                                                in: geometry.size.width
                                            )
                                        )
                                        .frame(maxHeight: .infinity)
                                    }
                                }
                                Color.gray
                                    .frame(maxHeight: .infinity)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .frame(height: 75)
                    
                        VStack(alignment: .leading){
                            ForEach(Satiety.allCases.indices.dropFirst(),id: \.self) { index in
                                HStack() {
                                    Color(Satiety.allCases[index].color).frame(width: 20, height: 20).cornerRadius(5)
                                    Text(Satiety.allCases[index].title)
                                        .foregroundStyle(Color.primary)
                                    
                                    Spacer()
                                }
                                .accessibilityHidden(true)
                                
                            }
                        }
                        
                        

                        
                    }
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemBackground))
                    .cornerRadius(12)

                    
                    StatisticCardView(statistic: .saciedade)

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
            .background(Color(.secondarySystemBackground))

        }
        
    }
    
    func generateWidth(
        for percentage: Double,
        in total: Double
    ) -> CGFloat {
        let result = total * (percentage/100)
        return result
    }

}

#Preview {
    SacietyView()
}
