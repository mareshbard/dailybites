//
//  PreferencesView.swift
//  DailyBites
//
//  Created by USER on 24/04/26.
//

import SwiftUI
import SwiftData
struct MealsView: View {
    @Query(sort: \Meal.time, order: .forward) var meals: [Meal]
    
//    
    @Environment(\.modelContext) var modelContext
    @AppStorage("lastOpen") var lastOpen = ""
    @State var auxMeals: [Meal] = []
    
    var todayMeals: [Meal] {
        return meals.filter { meal in
            Calendar.current.isDateInToday(meal.date)
        }
    }
    
    var body: some View {
        
        VStack(alignment: .trailing) {
            List {
            
                ForEach(todayMeals) { meal in
                    ZStack {
                        MealCardView(meal: meal)
                        
                        
                    }
                    .padding(-20)
                    .listRowInsets(EdgeInsets())
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    var meal = Meal(mealName: "Café da Manhã", date: .now, time: .now, imageData: nil, durationMeal: 0, status: .pulou, descriptionMeal: "", emotion: .normal)
    var meal2 = Meal(mealName: "Jantar", date: .now, time: .now, imageData: nil, durationMeal: 0, status: .atrasado, descriptionMeal: "", emotion: .normal)
    
    MealsView()
}
