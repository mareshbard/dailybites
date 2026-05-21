import SwiftUI

struct MealCardView: View {
    
    var meal: Meal
    
    var todayLog: LogMeal? {
        meal.logs.first { log in
            Calendar.current.isDateInToday(log.date)
        }
    }
    
    var body: some View {
        NavigationLink(destination: AddLogMealView(meal: meal)) {
      
            VStack(alignment: .leading) {
                
                Text(meal.name)
                    .font(.title3)
                    .bold()
                    .foregroundStyle(Color.primary)
                Text(meal.time, style: .time)
                    .font(.body)
                
                if let todayLog {
                    Text(todayLog.status.title)
                        .padding(.vertical, 1)
                        .padding(.horizontal, 9)
                        .foregroundStyle(todayLog.color)
                        .font(.body)
                        .overlay {
                            
                            RoundedRectangle( cornerRadius: 12)
                            
                                .fill(.clear)
                                .stroke(todayLog.color, style: StrokeStyle(lineWidth: 0.5))
                                .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
                        }
                } else {
                    Text("Pendente")
                        .padding(.vertical, 1)
                        .padding(.horizontal, 9)
                        .foregroundStyle(Color.gray)
                        .font(.body)
                        .overlay {
                            
                            RoundedRectangle( cornerRadius: 12)
                            
                                .fill(.clear)
                                .stroke(Color.gray, style: StrokeStyle(lineWidth: 0.5))
                                .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
                        }
                }
                
            }
        }
            .padding(.vertical, 13)
            .padding(.horizontal, 15)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.clear)
                    .stroke(Color.gray, style: StrokeStyle(lineWidth: 0.5))
            }
            .padding(24)
        }
    }


#Preview {
    // let meal = Meal(mealName: "Pasta", date: Date(), time: Date(), durationMeal: 20, status: Status.pulou, descriptionMeal: "Simple pasta", emotion: .normal)
    // MealCardView(meal: meal)
}
