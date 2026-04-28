//
//  RefeicoesView.swift
//  DailyBites
//
//  Created by USER on 27/04/26.
//

import SwiftUI
import SwiftData
struct RefeicoesView: View {
    var user: User
    
    var body: some View {
        let range = 1...user.numberOfMeals
        List {
            ForEach(range, id: \.self) { i in
                Text(user.meals[i].mealName)
                    .foregroundColor(Color.red)
                }
            }
        }
    }
    
#Preview {
    //RefeicoesView()
}
