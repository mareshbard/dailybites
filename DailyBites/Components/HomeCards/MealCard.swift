import SwiftUI

struct MealCardView: View {
    
    @State private var showAddLog: Bool = false
    
    var meal: Meal
    
    var todayLog: LogMeal? {
        meal.logs.first { log in
            Calendar.current.isDateInToday(log.date)
        }
    }
    
    var body: some View {
        
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
                if todayLog.ref!.isFixed == false {
                    Text("Refeição extra")
                        .padding(.vertical, 5)
                        .padding(.horizontal, 15)
                        .background(todayLog.color)
                        .foregroundStyle(todayLog.fontColor)
                        .cornerRadius(52)
                        .font(Font.custom("PlusJakartaSans-Medium", size: 15))
                } else {
                    Text(todayLog.status.title)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 15)
                        .background(todayLog.color)
                        .foregroundStyle(todayLog.fontColor)
                        .cornerRadius(52)
                        .font(Font.custom("PlusJakartaSans-Medium", size: 15))
                }
                
                
            } else {
                Text("Pendente")
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    .background(Color.pendenteTag)
                    .foregroundStyle(Color.corPendente)
                    .cornerRadius(52)
                    .font(Font.custom("PlusJakartaSans-Medium", size: 15))
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityHint("Clique para registrar ou editar a refeição")
        .frame(maxWidth: .infinity)
        
        .sheet(isPresented: $showAddLog) {
            if meal.isFixed {
                SheetAddLogMealView(meal: meal)
            } else {
                SheetAddNewMeal(meal: meal)
            }
            
        }
        
        .padding(20)
        .background(Color("mealBackground"))
        .cornerRadius(15)
        .onTapGesture {
            showAddLog = true
        }
    }
}


#Preview {
    let meal1 = Meal(name: "Café da manhã", logs: [], time: .now, isFixed: false)
    MealCardView(meal: meal1)
}
