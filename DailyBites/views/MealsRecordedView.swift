import SwiftUI
import SwiftData



struct MealsRecordedView: View {
    @Query(sort: \Meal.time, order: .forward) var meals: [Meal]

    var recordedMeals: [Meal] {
        return meals.filter { meal in
            meal.status != .pendente && meal.status != .pulou
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
                        MealRecordedCard(meal: meal)
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
    MealsRecordedView()
}
