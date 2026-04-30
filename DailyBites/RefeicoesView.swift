//
//  PreferencesView.swift
//  DailyBites
//
//  Created by USER on 24/04/26.
//

import SwiftUI
import SwiftData
struct RefeicoesView: View {
    // var user: User
    @State var meals: [Meal]
    @Environment(\.modelContext) var modelContext
    var body: some View {
        
        
        List {
            ForEach(meals) { meal in
                ZStack {
                    if meal.date.formatted(date: .abbreviated, time: .omitted) == Date().formatted(date: .abbreviated, time: .omitted) {
                        MealCardView(meal: meal)
                    }
                }
                .padding(-20)
                .listRowInsets(EdgeInsets())
            }
            .onDelete{ offsets in
                for index in offsets {
                    let meal = meals[index]
                    modelContext.delete(meal)
                    meals.remove(at: index)
                }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

#Preview {
    var meal = Meal(mealName: "Café da Manhã", date: .now, time: .now, imageData: nil, durationMeal: 0, status: .pulou, descriptionMeal: "")
    var meal2 = Meal(mealName: "Jantar", date: .now, time: .now, imageData: nil, durationMeal: 0, status: .atrasado, descriptionMeal: "")
    //   var user = User(username: "Test User", meals: [meal, meal2])
    
    RefeicoesView(meals: [meal, meal2])
}
