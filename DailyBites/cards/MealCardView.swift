import SwiftUI


struct MealCardView: View {
    
    var meal: Meal
    var body: some View {
        NavigationLink (destination: AddMealView(meal: meal)){
            
            VStack(alignment: .leading) {
                Text(meal.mealName)
                    .font(.title3)
                    .bold()
                    .foregroundStyle(Color.primary)
                Text(meal.time, style: .time)
                    .font(.body)
                
                Text(meal.status.title)
                    .padding(.vertical, 1)
                    .padding(.horizontal, 9)
                    .foregroundStyle(meal.color)
                    .font(.body)
                    .overlay {
                        
                        RoundedRectangle( cornerRadius: 12)
                        
                            .fill(.clear)
                            .stroke(meal.color, style: StrokeStyle(lineWidth: 0.5))
                            .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
                    }
            }
        }
        .padding(.vertical, 13)
        .padding(.horizontal, 15)
        .overlay {
            RoundedRectangle( cornerRadius: 12)
                .fill(.clear)
                .stroke(Color.gray, style: StrokeStyle(lineWidth: 0.5))
        }
        .padding(24)
    }
}

#Preview {
    let meal = Meal(mealName: "Pasta", date: Date(), time: Date(), durationMeal: 20, status: Status.pulou, descriptionMeal: "Simple pasta", emotion: .normal)
    MealCardView(meal: meal)
}
