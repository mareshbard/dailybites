
import SwiftUI
import SwiftData


struct HomeView: View {
    
    @Environment(\.modelContext) var modelContext
    @AppStorage("username") var username = ""
    @AppStorage("firstTime") var firstTime = false
    @AppStorage("lastOpen") var lastOpen = ""
    @AppStorage("numberOfMeals") var numberOfMeals: Int = 1
    @Query(sort: \Meal.time, order: .forward) var meals: [Meal]
    @AppStorage("firstUse") var firstUse: Bool = false
    @Query(sort: \LogMeal.date, order: .forward) var logs: [LogMeal]
    @State private var isActive: Bool = false
    @SceneStorage("selectedTab") private var selectedTabIndex: Int = 0
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
                HStack {
                    Text("Refeições do dia")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
  
                    Button("Adicionar"){
                        isActive = true
                    }
                    NavigationLink(destination: AddNewMealView(meal: Meal(name: "", logs: [], time: Date(), isFixed: false)), isActive: $isActive){

                    }
                }
                MealsView()
                    .navigationBarHidden(true)
            }
            .padding(.horizontal, 24)
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
}

#Preview {
    HomeView()
}
