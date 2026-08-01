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

    @Query(sort: \Meal.time, order: .forward) var meals: [Meal]
    @Environment(\.dismiss) private var dismiss

    private let maxMeals = 10

    var body: some View {
        NavigationStack {
            VStack {
                VStack {
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
                            guard auxMeals.count < maxMeals else { return }
                            auxMeals.append(createMeal())
                            numberOfMeals += 1
                        }
                        .tint(Color.roxoAcao)
                        .disabled(auxMeals.count >= maxMeals)
                    }
                }

                List {
                    ForEach(auxMeals) { meal in
                        AddMealCardView(meal: meal)
                            .listRowInsets(EdgeInsets())
                            .padding(.bottom, 14)
                    }
                    .onDelete { offsets in
                        guard auxMeals.count > offsets.count else { return } // impede ficar com 0 refeições

                        for index in offsets {
                            let mealToRemove = auxMeals[index]
                            
                            if meals.contains(where: { $0.persistentModelID == mealToRemove.persistentModelID }) {
                                modelContext.delete(mealToRemove)
                            }
                        }

                        auxMeals.remove(atOffsets: offsets)
                        numberOfMeals = auxMeals.count
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .scrollIndicators(.hidden)
                .scrollDismissesKeyboard(.immediately)
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                Button {
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
                    Label("Concluir", systemImage: "")
                        .frame(maxWidth: .infinity)
                }
                .disabled(auxMeals.isEmpty || auxMeals.contains(where: { $0.name.isEmpty }))
                .buttonStyle(.borderedProminent)
                .font(Font.title3)
                .controlSize(.large)
                .tint(Color.roxoAcao)
                .foregroundColor(Color(.white))
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .onAppear {
                if firstUse {
                    auxMeals = meals
                } else {
                    let initialCount = min(numberOfMeals, maxMeals)
                    for _ in 1...max(initialCount, 1) {
                        auxMeals.append(createMeal())
                    }
                }
                Notifications.requestNotificationAuthorization()
            }
            .navigationDestination(isPresented: $isActive) {
                HomeView()
            }
        }
    }

    func createMeal() -> Meal {
        return Meal(name: "", logs: [], time: .now, isFixed: true)
    }
}
