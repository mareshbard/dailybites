//
//  PreferencesView.swift
//  DailyBites
//
//  Created by USER on 24/04/26.
//

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
            VStack{
                Text("Refeições")
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Escolha o nome e horário de suas refeições")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.body)
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Adicionar refeição", systemImage: "plus") {
                        //estou adicionando direto no array > talvez n seja o que vamos fazer
                        //adicionando no aux
                        auxMeals.append(createMeal())
                        numberOfMeals += 1
                    }
                    .tint(Color(.red))
                }
            }
            
            
            List {
                ForEach(auxMeals) { meal in
                    ZStack {
                        RoundedRectangle( cornerRadius: 12)
                            .fill(.clear)
                            .stroke(Color.red, style: StrokeStyle(lineWidth: 0.5))
                        AddMealCardView(meal: meal)
                            .padding(.vertical, 10)
                        
                    }
                    .padding(-8)
                }
                
                .onDelete{ offsets in
                    for index in offsets {
                        auxMeals.remove(at: index)
                        numberOfMeals -= 1
                    }
                }
                .listRowSeparator(.hidden)
                
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .scrollIndicators(.hidden)
        }
        .onAppear(){
            for _ in rangeMeals {
                auxMeals.append(createMeal())
            }
        }
        
        NavigationLink(destination: HomeView()){
        }
        Button("Concluir"){
            self.isActive = true
            username = username1
            firstUse = true
            for meal in auxMeals {
                modelContext.insert(meal)
            }
        }
        
        .buttonStyle(.borderedProminent)
        .buttonSizing(.flexible)
        .font(Font.title3)
        .controlSize(.large)
        .tint(.red)
        .foregroundColor(Color(.white))
        
    }
    
    func createMeal() -> Meal {
        return Meal(mealName: "", date: .now, time: .now, imageData: nil, durationMeal: 0, status: .pendente, descriptionMeal: "", emotion: .normal)
    }
}

#Preview {
    
}
