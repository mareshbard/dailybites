import SwiftUI


struct MealRecordedCard: View {
    
    var meal: Meal
    var body: some View {
        NavigationStack{
            
            VStack(alignment: .leading) {
                if let image = meal.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .clipShape(UnevenRoundedRectangle(topLeadingRadius: 12, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 12))
                }
                HStack {
                    VStack(alignment: .leading) {
                        Text(meal.mealName)
                            .font(.title3)
                            .bold()
                            .foregroundStyle(Color(.black))
                        Text(meal.time, format: .dateTime.day().month().year().hour().minute())
                            .font(.body)
                    }
                    Spacer()
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
                .padding(20)
            }
        }
        
        .overlay {
            RoundedRectangle( cornerRadius: 12)
                .fill(.clear)
                .stroke(Color.gray, style: StrokeStyle(lineWidth: 0.5))
        }
        .padding(.vertical, 24)
    }
}

#Preview {
    let meal = Meal(mealName: "Pasta", date: Date(), time: Date(), durationMeal: 20, status: Status.pulou, descriptionMeal: "Simple pasta", emotion: .normal)
    MealCardView(meal: meal)
}
