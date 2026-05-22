import SwiftUI
import SwiftData
struct MealsView: View {
    @Query(sort: \Meal.time, order: .forward) var meals: [Meal]
    @Environment(\.modelContext) var modelContext
    @AppStorage("lastOpen") var lastOpen = ""
    @State var auxMeals: [Meal] = []
    @Query(sort: \LogMeal.date, order: .forward) var logs: [LogMeal]
//    var todayMeals: [Meal] {
//        return meals.filter { meal in
//            Calendar.current.isDateInToday(meal.date)
//        }
//    }
    
    var body: some View {
        
        VStack(alignment: .trailing) {
            List {
                
                ForEach(meals) { meal in
                    ZStack{
                        MealCardView(meal: meal)
                    }
                        .padding(-20)
                        .listRowInsets(EdgeInsets())
                }
                .listRowSeparator(.hidden)
            }
            .scrollIndicators(.hidden)
            .listStyle(.plain)
        }
    }
}

#Preview {
//    var meal = Meal(mealName: "Café da Manhã", date: .now, time: .now, imageData: nil, durationMeal: 0, status: .pulou, descriptionMeal: "", emotion: .normal)
//    var meal2 = Meal(mealName: "Jantar", date: .now, time: .now, imageData: nil, durationMeal: 0, status: .atrasado, descriptionMeal: "", emotion: .normal)
//
    NavigationStack {
        MealsView()
            
    }
    .modelContainer(for: [Meal.self, LogMeal.self], inMemory: true) {
        guard let modelContext = try? $0.get().mainContext else {
            return
        }
        
        let meal1 = Meal(name: "Meal 1", logs: [], time: .now)
        let meal2 = Meal(name: "Meal 2", logs: [], time: .now)
        
        modelContext.insert(meal1)
        modelContext.insert(meal2)
        //            modelContext.insert(
        //                LogMeal(ref: meal1, date: .now, durationMeal: 10, status: .pontual, descriptionMeal: "", emotion: .happy)
        //            )
    }
}
