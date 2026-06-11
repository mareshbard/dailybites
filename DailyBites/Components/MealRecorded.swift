import SwiftUI


struct MealRecordedCard: View {
    
    var log: LogMeal
    var body: some View {
        NavigationStack{
            NavigationLink (destination: AddNewMealView(meal: log.ref!)){
                VStack(alignment: .leading) {
                    if let image = log.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .clipShape(UnevenRoundedRectangle(topLeadingRadius: 12, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 12))
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            Text(log.ref!.name)
                                .font(.title3)
                                .bold()
                                .foregroundStyle(Color.primary)
                            Text(log.ref!.time, format: .dateTime.hour().minute())
                                .font(.body)
                        }
                        Spacer()
                        Text(log.status.title)
                            .padding(.vertical, 1)
                            .padding(.horizontal, 9)
                            .foregroundStyle(log.color)
                            .font(.body)
                            .overlay {
                                
                                RoundedRectangle( cornerRadius: 12)
                                
                                    .fill(.clear)
                                    .stroke(log.color, style: StrokeStyle(lineWidth: 0.5))
                                    .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
                            }
                    }
                    .padding(20)
                }
            }
            .navigationLinkIndicatorVisibility(.hidden)
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
    //    let meal = Meal(mealName: "Pasta", date: Date(), time: Date(), durationMeal: 20, status: Status.pulou, descriptionMeal: "Simple pasta", emotion: .normal)
    //    MealCardView(meal: meal)
}
