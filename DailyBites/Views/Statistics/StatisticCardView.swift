//
//  StatisticCardView.swift
//  DailyBites
//
//  Created by Lucas Ibiapina on 15/06/26.
//

import SwiftUI

struct StatisticCardView: View {
    let statistic: StatisticsTypes
    
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize: DynamicTypeSize
    var dynamicLayout: AnyLayout {
        dynamicTypeSize.isAccessibilitySize
        ? AnyLayout(VStackLayout())
        : AnyLayout(HStackLayout())
    }
    
    var body: some View {
        VStack {
            Text(statistic.question)
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            dynamicLayout {
                Text(statistic.description)
                
                Image(statistic.imageName)
                    .padding(10)
            }
            
        }
        .padding(20)
        .background(Color("BackgroundCard"))
        .listRowSeparator(.hidden)
        .cornerRadius(12)
    }
}

#Preview {
    ScrollView {
        VStack {
            ForEach(StatisticsTypes.allCases, id: \.self) {
                statistc in
                StatisticCardView(statistic: statistc)
            }
        }
    }
    
}
