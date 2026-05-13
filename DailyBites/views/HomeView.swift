
import SwiftUI
import SwiftData


//
//@Model
//class Ref {
//    var name: String
//    var logs: [LogRef]
//
//    init(name: String, logs: [LogRef]) {
//        self.name = name
//        self.logs = logs
//    }
//}
//
//@Model
//class LogRef {
//    var ref: Ref?
//    var date: Date
//    var status: String
//    init(ref: Ref? = nil, date: Date, status: String) {
//        self.ref = ref
//        self.date = date
//        self.status = status
//    }
//}

struct HomeView: View {
    
    @Environment(\.modelContext) var modelContext
    @AppStorage("username") var username = ""
    @AppStorage("firstTime") var firstTime = false
    @AppStorage("lastOpen") var lastOpen = ""
    @AppStorage("numberOfMeals") var numberOfMeals: Int = 1
    @Query(sort: \Meal.time, order: .forward) var meals: [Meal]
    @AppStorage("firstUse") var firstUse: Bool = false
    
    var body: some View {
        
        NavigationStack {
            VStack{
                VStack{
                    Text("Olá, \(username)")
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(Date(), style: .date)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.body)
                }
                .padding(.vertical,20)
                StreakCard()
                Text("Refeições do dia")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                MealsView()
                    .navigationBarHidden(true)
            }
            .padding(.horizontal, 24)
        }
        
        .onAppear{
            checkToday()
            if (firstTime == true){
                newMeals()
                firstUse = false
            }
        }
    }
    
    func checkToday() {
        
        let today = Date().formatted(date: .abbreviated, time: .omitted)
        
        if lastOpen == today {
            firstTime = false
        } else {
            lastOpen = today
            firstTime = true
        }
    }
    
    func newMeals() {
        let today = Date().formatted(date: .abbreviated, time: .omitted)
  
        guard !meals.contains(where: { $0.date.formatted(date: .abbreviated, time: .omitted) == today }) else { return }
        
        let firstDay = meals.first?.date.formatted(date: .abbreviated, time: .omitted) ?? ""
        let templateMeals = meals.filter {
            $0.date.formatted(date: .abbreviated, time: .omitted) == firstDay
        }
        for meal in templateMeals {
            modelContext.insert(Meal(mealName: meal.mealName, date: Date(), time: meal.time, durationMeal: 0, status: .pendente, descriptionMeal: "", emotion: .normal))
            print("New Meal Inserted")
        }
    }
}

#Preview {
    HomeView()
}
