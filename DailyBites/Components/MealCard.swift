import SwiftUI

struct MealCardView: View {
    
    var meal: Meal
    @State private var showSheetAddLogMeal: Bool = false
    var todayLog: LogMeal? {
        meal.logs.first { log in
            Calendar.current.isDateInToday(log.date)
        }
    }
    
    var body: some View {
        NavigationLink(destination: SheetAddLogMealView(meal: meal)) {
            
            VStack(alignment: .leading) {
                
                Text(meal.name)
                    .font(.title3)
                    .bold()
                    .foregroundStyle(Color.primary)
                Text(meal.time, style: .time)
                    .font(.body)
                
        NavigationLink(destination: EditLogMeal(meal: meal)) {
            
            HStack {
                VStack(alignment: .leading){
                    Text(meal.name)
                        .font(Font.custom("PlusJakartaSans-Semibold", size: 20))
                        .foregroundStyle(Color.primary)
                        .padding(.bottom, 2)
                    Text(meal.time, style: .time)
                        .font(Font.custom("PlusJakartaSans-Medium", size: 17))
                        .foregroundColor(Color.primary)
                       // .accessibilityHint(Text("Horário da refeição"))
                }
                Spacer()
                if let todayLog {
                    Text(todayLog.status.title)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 15)
                        .background(todayLog.color)
                        .foregroundStyle(todayLog.fontColor)
                        .cornerRadius(52)
                        .font(Font.custom("PlusJakartaSans-Medium", size: 15))
                } else {
                    Text("Pendente")
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(Color.pendenteTag.opacity(0.2))
                        .foregroundStyle(Color.corPendente)
                        .cornerRadius(52)
                        .font(Font.custom("PlusJakartaSans-Medium", size: 15))
                }
                
            }
            //        }
            .padding(.vertical, 13)
            .padding(.horizontal, 15)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.clear)
                    .stroke(Color.gray, style: StrokeStyle(lineWidth: 0.5))
                //                    .frame(minWidth: .infinity, minHeight: 100)
                //                    .onTapGesture {
                //                        showSheetAddLogMeal = true
            }
            .sheet(isPresented: $showSheetAddLogMeal) {
                SheetAddLogMealView(meal: meal)
            }
        }
        .padding(24)
            }
        }
        .accessibilityHint("Clique para registrar ou editar a refeição")
        .frame(maxWidth: .infinity)
        .padding(20)
        .background(Color.white)
        .cornerRadius(15)
    }
}


#Preview {
    // let meal = Meal(mealName: "Pasta", date: Date(), time: Date(), durationMeal: 20, status: Status.pulou, descriptionMeal: "Simple pasta", emotion: .normal)
    //     MealCardView(meal: meal)
    let meal1 = Meal(name: "Café da manhã", logs: [], time: .now, isFixed: false)
    let meal2 = Meal(name: "Meal 2", logs: [], time: .now, isFixed: false)
    MealCardView(meal: meal1)
}
