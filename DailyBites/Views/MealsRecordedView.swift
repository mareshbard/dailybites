import SwiftUI
import SwiftData



struct MealsRecordedView: View {
   // @Query(sort: \Meal.date, order: .reverse) var meals: [Meal]
    @State private var date = Date()
    @Query(sort: \LogMeal.date, order: .forward) var logs: [LogMeal]
    var recordedMeals: [LogMeal] {
        return logs.filter { log in
            log.status != .pendente && log.status != .pulou
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    
                    DatePicker("Escolha a data",
                               selection: $date,
                               displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                    .background(Color(.systemBackground))
                    .cornerRadius(10)
                    Text(date.formatted(date: .long, time: .omitted))
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    VStack {
                        ForEach(recordedMeals) { meal in
                            if meal.date.formatted(date: .numeric, time: .omitted) == date.formatted(date: .numeric, time: .omitted) {
                                LogRecorded(log: meal)
                                
                            }
                        }
                        .listRowSeparator(.hidden)
                        .padding(.vertical, -28)
                        
                    }
                    .scrollIndicators(.hidden)
                    .listStyle(.plain)
                    .padding(-20)
                    .listRowInsets(EdgeInsets())
                }
                
            }
            .navigationTitle("Calendário")
            
            .padding(20)
            .background(Color.backgroundCor)
        }
        
    }
}

#Preview {
  //  MealsRecordedView()
}
