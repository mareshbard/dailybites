import SwiftUI


struct MealRecordedCard: View {
    
    var meal: Meal
    var body: some View {
        NavigationLink (destination: AddMealView(meal: meal)){
            
            VStack(alignment: .leading) {
                if let image = meal.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 100)
                        .padding(10)
                }
                Text(meal.mealName)
                    .font(.title3)
                    .bold()
                    .foregroundStyle(Color(.black))
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
