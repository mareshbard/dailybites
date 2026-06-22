import SwiftUI
import SwiftData
import UserNotifications

struct HomeView: View {
    
    @Environment(\.modelContext) var modelContext
    @AppStorage("username") var username = ""
    
    @Query(sort: \Meal.time, order: .forward) var meals: [Meal]
    @AppStorage("firstUse") var firstUse: Bool = false
    @AppStorage("isNotificationAuthorized") var isNotificationAuthorized: Bool = false
    @Query(sort: \LogMeal.date, order: .forward) var logs: [LogMeal]
    @State private var isActive: Bool = false
    @State private var showCalendar: Bool = false
    @State private var showPreferences: Bool = false
    @SceneStorage("selectedTab") private var selectedTabIndex: Int = 0
    @State private var showAddNewMeal: Bool = false
  //  @Environment(TipsManager.self) private var tipsManager: TipsManager
    
    var visibleMeals: [Meal] {
        meals.filter { meal in
            if meal.isFixed {
                return true
            } else {
                let hasLogToday = logs.contains { log in
                    log.ref == meal && Calendar.current.isDateInToday(log.date)
                }
                return hasLogToday
            }
        }
    }
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView{
                HStack{
                    
                    VStack{
                        Text("Olá, \(username)")
                            .font(.largeTitle)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(Color.primary)
                        Text(Date(), style: .date)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.body)
                    }
                    Button{
                        self.showPreferences = true
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .padding(10)
                            .font(Font.system(.title2))
                            .tint(Color.white)
                            .background(Color.roxoAcao)
                            .cornerRadius(100)
                            .accessibilityLabel(Text("Editar refeições fixas"))
                    }
                    .sheet(isPresented: $showPreferences) {
                        PreferencesSheet(username1: username)
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
                        }))
                        DurationCard()
                    }
                }
                HStack {
                    Text("Refeições do dia")
                        .font(.title)
                        .foregroundStyle(Color.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(Font.custom("PlusJakartaSans-SemiBold", size: 22))
                    
                    Button{
                        
                        isActive = true
                        showAddNewMeal = true
                    } label: {
                        VStack(alignment: .trailing, spacing: -4) {
                            Text("Registrar")
                            Text("extra")
                        }
                    }
                   
                    .foregroundColor(Color.roxoAcao)
                    .font(Font.custom("PlusJakartaSans-SemiBold", size: 16))
                    .sheet(isPresented: $showAddNewMeal) {
                        SheetAddNewMeal(meal: Meal(name: "", logs: [], time: Date(), isFixed: false))
                    }
                }
                .padding(.top, 31)
                .padding(.bottom, 16)
                NavigationLink(destination: MealsRecordedView(), isActive: $showCalendar){
                    
                }
                
                VStack {
                    ForEach(visibleMeals) { meal in
                        MealCardView(meal: meal)
                    }
                    
                }
                .cornerRadius(12)
                .listRowBackground(Color.clear)
                
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
//        .onAppear {
//            tipsManager.start()
//        }
    }
}

#Preview {
    HomeView()
}
