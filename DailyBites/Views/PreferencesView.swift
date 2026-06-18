import SwiftUI
import SwiftData
struct PreferencesView: View {
    
    @Environment(\.modelContext) var modelContext
    var username1: String
    @AppStorage("username") var username = ""
    @State private var isActive: Bool = false
    @AppStorage("numberOfMeals") var numberOfMeals: Int = 1
    @State private var auxMeals: [Meal] = []
    @AppStorage("firstUse") var firstUse: Bool = false
 
    
    var body: some View {
        let rangeMeals =  1...numberOfMeals
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false){
                
                
                VStack{
                    Text("Refeições")
                        .font(Font.custom("PlusJakartaSans-SemiBold", size: 48))
                    //  .font(.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Defina nomes e horários para suas refeições fixas")
                        .font(Font.custom("PlusJakartaSans-SemiBold", size: 20))
                        .foregroundColor(Color.cinzaFonte)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.body)
                }
                .padding(.bottom, 35)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Adicionar mais uma refeição", systemImage: "plus") {
                            auxMeals.append(createMeal())
                            numberOfMeals += 1
                        }
                        .tint(Color.roxoAcao)
                    }
                }
                
                
                VStack {
                    
                    ForEach(auxMeals) { meal in
                        AddMealCardView(meal: meal)
                    }
                    // não funciona sem o list, list precisa setar tamanho
                    .onDelete{ offsets in
                        for index in offsets {
                            auxMeals.remove(at: index)
                            numberOfMeals -= 1
                        }
                    }
              
                    .padding(.bottom, 13)
                   // .listRowSeparator(.hidden)
                    
                }
               // .frame(height: CGFloat(numberOfMeals * 300))
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .scrollIndicators(.hidden)
                Spacer()
                Button{
                    self.isActive = true
                    username = username1
                    firstUse = true
                    for meal in auxMeals {
                        modelContext.insert(meal)
                        Notifications.sendNotification(for: meal)
                    }
                } label: {
                    Label("Concluir", systemImage: "")
                        .frame(maxWidth: .infinity)
                }
                
               // .padding(.horizontal, 20)
                .buttonStyle(.borderedProminent)
                //     .buttonSizing(.flexible)
                .font(Font.title3)
                .controlSize(.large)
                .tint(Color.roxoAcao)
                .foregroundColor(Color(.white))
                
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
          
                
                Spacer()
                NavigationLink(destination: HomeView(), isActive: $isActive){
                    
                }
                
            }
           // .padding()
            .scrollDismissesKeyboard(.immediately)
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .onAppear(){
                for _ in rangeMeals {
                    auxMeals.append(createMeal())
                }
                Notifications.requestNotificationAuthorization()
            }
    }
       
    
    func createMeal() -> Meal {
        return Meal(name: "", logs: [], time: .now, isFixed: true)
    }
}

//#Preview {
//    let meal1 = Meal(name: "Meal 1", logs: [], time: .now, isFixed: false)
//    let meal2 = Meal(name: "Meal 2", logs: [], time: .now, isFixed: false)
//    PreferencesView(username1: "d")
//}
