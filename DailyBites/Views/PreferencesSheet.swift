import SwiftUI
import SwiftData
struct PreferencesSheet: View {
    
    @Environment(\.modelContext) var modelContext
    var username1: String
    @AppStorage("username") var username = ""
    @State private var isActive: Bool = false
    @AppStorage("numberOfMeals") var numberOfMeals: Int = 1
    @State private var auxMeals: [Meal] = []
    @AppStorage("firstUse") var firstUse: Bool = false
    @Query(sort: \Meal.time, order: .forward) var meals: [Meal]
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        let rangeMeals =  1...numberOfMeals
        
        NavigationStack {
            VStack {
                
                VStack{
                    Text("Refeições")
                        .font(Font.custom("PlusJakartaSans-SemiBold", size: 48))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Defina nomes e horários para suas refeições fixas")
                        .font(Font.custom("PlusJakartaSans-SemiBold", size: 20))
                        .foregroundColor(Color.cinzaFonte)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.body)
                }
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Adicionar mais uma refeição", systemImage: "plus") {
                                auxMeals.append(createMeal())
                                numberOfMeals += 1
                            }
                            .tint(Color.roxoAcao)
                        }
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Fechar", systemImage: "xmark") {
                              dismiss()
                            }
                            .tint(Color.roxoAcao)
                        }
                    }
                
                
                List {
                    
                    ForEach(auxMeals) { meal in
                        AddMealCardView(meal: meal)
                            .listRowInsets(EdgeInsets())
                            .padding(.bottom, 14)
                    }
                    .onDelete{ offsets in
                        if meals.count > 1 {
                            for index in offsets {
                                auxMeals.remove(at: index)
                                let meal = meals[index]
                               modelContext.delete(meal)
                            }
                        }
                    }
                    .listRowSeparator(.hidden)
                }
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
                    
                    numberOfMeals = auxMeals.count
                    dismiss()
                } label: {
                    HStack{
                        Image(systemName: "plus")
                        Text("Adicionar refeição")
                    }       
                }
                .buttonStyle(.borderedProminent)
                .font(Font.title3)
                .controlSize(.large)
                .tint(Color.roxoAcao)
                .foregroundColor(Color(.white))
                
            }
            .scrollDismissesKeyboard(.immediately)
            .ignoresSafeArea(.keyboard, edges: .bottom)

            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .onAppear {
                if firstUse {
                    auxMeals = meals.filter({$0.isFixed == true})
                }
               
            }
            
            Spacer()
            .onAppear(){
                for _ in rangeMeals {
                    auxMeals.append(createMeal())
                }
                Notifications.requestNotificationAuthorization()
            }
        }
    }
       
    
    func createMeal() -> Meal {
        return Meal(name: "", logs: [], time: .now, isFixed: true)
    }
}

#Preview {
    let meal1 = Meal(name: "Meal 1", logs: [], time: .now, isFixed: false)
    let meal2 = Meal(name: "Meal 2", logs: [], time: .now, isFixed: false)
    PreferencesView(username1: "d")
}
