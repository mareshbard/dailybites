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
                
                List{
                    VStack{
                        Text("Refeições")
                            .font(Font.custom("PlusJakartaSans-SemiBold", size: 48))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        //    .frame(maxHeight: .greatestFiniteMagnitude)
                        Text("Defina nomes e horários para suas refeições fixas")
                            .font(Font.custom("PlusJakartaSans-SemiBold", size: 20))
                            .foregroundColor(Color.cinzaFonte)
                            .frame(maxWidth: .infinity, alignment: .leading)
                           // .frame(maxHeight: .greatestFiniteMagnitude)
                            .font(.body)
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                    .padding(.bottom, 14)
                       
                    //                List {
                    
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
                    Button{
                        auxMeals.append(createMeal())
                        
                        
                    } label: {
                        HStack{
                            Image(systemName: "plus.circle")
                            Text("Adicionar refeição")
                        }
                        .font(Font.title3)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 14)
                        .background(Color.roxoAcao)
                        .cornerRadius(12)
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    .font(Font.title3)
                    .foregroundColor(Color(.white))
                    //                }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .scrollIndicators(.hidden)
                
            }
            .scrollDismissesKeyboard(.immediately)
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .onAppear {
                
                    auxMeals = meals.filter({$0.isFixed == true})
                
            }
            Spacer()
                .onAppear(){
                    for _ in rangeMeals {
                        auxMeals.append(createMeal())
                    }
                    Notifications.requestNotificationAuthorization()
                }
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Salvar", systemImage: "checkmark") {
                            self.isActive = true
                            for meal in auxMeals {
                                modelContext.insert(meal)
                                Notifications.sendNotification(for: meal)
                            }
                            numberOfMeals = auxMeals.count
                            dismiss()
                        }
                        .disabled(auxMeals.isEmpty || auxMeals.contains(where: { $0.name.isEmpty }))
                        .tint(Color.roxoAcao)
                    }
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Fechar", systemImage: "xmark") {
                            dismiss()
                        }
                        .tint(Color.roxoAcao)
                    }
                }
            
        }
    }
    
    
    func createMeal() -> Meal {
        return Meal(name: "", logs: [], time: .now, isFixed: true)
    }
}

#Preview {
    PreferencesView(username1: "d")
}
