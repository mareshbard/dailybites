import SwiftUI
import SwiftData



struct MealsRecordedView: View {
   // @Query(sort: \Meal.date, order: .reverse) var meals: [Meal]
    @Query(sort: \LogMeal.date, order: .forward) var logs: [LogMeal]
    var recordedMeals: [LogMeal] {
        return logs.filter { log in
            log.status != .pendente && log.status != .pulou
        }
    }
    
    var body: some View {
        NavigationStack {
            
            VStack {
                Text("Registros")
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                List {
                    ForEach(recordedMeals) { meal in
                        MealRecordedCard(log: meal)
                    }
                    .listRowSeparator(.hidden)
                    .padding(.vertical, -28)
                   
                }
                .scrollIndicators(.hidden)
                .listStyle(.plain)
                .padding(-20)
                .listRowInsets(EdgeInsets())
            }
            .padding(24)
        }
    }
}

#Preview {
  //  MealsRecordedView()
}
