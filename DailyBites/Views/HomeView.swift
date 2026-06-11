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
    @State var palavra: String = ""
    var body: some View {
        
        NavigationStack {
            
            ScrollView{
                HStack{
                    
                    
                    VStack{
                        Text("Olá, \(username)")
                            .font(.largeTitle)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(Date(), style: .date)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.body)
                    }
                    Button{
                        
                    } label: {
                        Image(systemName: "calendar")
                      //  Image(systemName: "calendar")
                            .padding(15)
                            .font(Font.system(.title2))
                            .tint(Color.white)
                            .background(Color.roxoAcao)
                            .cornerRadius(100)
                            .accessibilityLabel(Text("Ver refeições no calendário"))
                    }
                }
                .padding(.vertical,20)
                ViewThatFits {
                    HStack(alignment: .top){
                        StreakCard()
                        VStack{
                            DailyMealsCard(qtd: logs.count(where: { Calendar.current.isDateInToday($0.date)
                            }))
                            DurationCard()
                        }
                    }
                    
                    
                    VStack{
                        StreakCard()
                        DailyMealsCard(qtd: logs.count(where: { Calendar.current.isDateInToday($0.date)
                        }
                                                       ))
                        DurationCard()
                    }
                }
                HStack {
                    Text("Refeições do dia")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
  
                    Button("Adicionar"){
                        isActive = true
                        numberOfMeals += 1
                    }
                    .foregroundColor(Color.roxoAcao)
                    .font(Font.custom("PlusJakartaSans-Bold", size: 18))
                    NavigationLink(destination: AddNewMealView(meal: Meal(name: "", logs: [], time: Date(), isFixed: false)), isActive: $isActive){

                    }
                }
                    VStack {
                        ForEach(meals) { meal in
                                MealCardView(meal: meal)
                        }
                        
                    }
                    .cornerRadius(12)
                    .listRowBackground(Color.clear)
                     // .listRowSeparator(.hidden)
                    
                    .edgesIgnoringSafeArea(.all)
                    .background(Color.backgroundCor)
                    .scrollIndicators(.hidden)
                    .listStyle(.plain)
                }
                    .navigationBarHidden(true)
                    .scrollIndicators(.hidden)
           // }
            .padding(.horizontal, 20)
            .background(Color.backgroundCor)
            
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
