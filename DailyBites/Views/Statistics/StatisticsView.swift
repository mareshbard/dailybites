//
//  StatisticsView.swift
//  DailyBites
//
//  Created by user on 28/04/26.
//

import SwiftUI
import SwiftData
import Charts



struct StatisticsView: View {

    @State private var isActive1: Bool = false
    @State private var isActive2: Bool = false
    @State private var isActive3: Bool = false
    
    @State private var selectedType: StatisticsTypes? = nil
    
    var body: some View{
        NavigationStack {
            ScrollView{
                VStack{
                    VStack{
                        
                        VStack(spacing: 10) {
                            ForEach(StatisticsTypes.allCases.indices, id: \.self) { statistic in
                                // MARK: Para cada um dos casos no enum ele gera um botão
                                Button {
                                    // MARK: Ação do botão
                                    selectedType = StatisticsTypes.allCases[statistic]
                                } label: {
                                    // MARK: Visual do botão
                                    HStack {
                                        
                                        Image(StatisticsTypes.allCases[statistic].iconName)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 70, height: 70)

                                        Label(
                                            
                                            StatisticsTypes.allCases[statistic].rawValue,
                                            systemImage: StatisticsTypes.allCases[statistic].iconName
                                        )
                                        .font(.headline)
                                        .foregroundStyle(Color.primary)
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                            .foregroundStyle(Color.primary)

                                    }
                                    .padding(20)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color("BackgroundCard"))
                                    .frame(maxWidth: .infinity)
                                }
                                .accessibility(label: Text("\(StatisticsTypes.allCases[statistic].rawValue) Button"))
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        
                        
                        
                        
                    }
                    
                }
                .padding(20)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationTitle("Estatísticas")
            .background(Color.backgroundCor)
            .sheet(item: $selectedType) { selected in
                switch selected {
                case .pontualidade:
                    PontualityView()
                case .resistroSemanal:
                    QuantityMealsView()
                case .humor:
                    MoodbarView()
                case .tempoDasrefeicoes:
                    DurationMealView()
                case .saciedade:
                    SacietyView()
                case .totalDerefeicoes:
                    TotalMealsView()
                }
            }
        }
    }
    
}


extension Calendar {
    private var currentDate: Date { return Date() }
    
    func isDateInThisWeek(_ date: Date) -> Bool {
        return isDate(date, equalTo: currentDate, toGranularity: .weekOfYear)
    }
}

#Preview {
    StatisticsView()
}
