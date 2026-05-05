
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
    @Query(sort: \Meal.date, order: .forward) var meals: [Meal]
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
    
    func newMeals(){
        print(numberOfMeals)
        for i in 0..<numberOfMeals {
            let firstDay = meals[0].date.formatted(date: .abbreviated, time: .omitted)
            
            if (meals[i].date.formatted(date: .abbreviated, time: .omitted) == firstDay
                && firstTime == true && firstUse == false) {
                
                modelContext.insert(Meal(mealName: meals[i].mealName, date: Date(), time: meals[i].time, durationMeal: 0, status: .pendente, descriptionMeal: "", emotion: .normal))
                print("New Meal Inserted")
                
//                firstTime = false
                
            }
        }
    }
}

#Preview {
    
    
    HomeView()
}
