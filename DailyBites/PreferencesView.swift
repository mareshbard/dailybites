//
//  PreferencesView.swift
//  DailyBites
//
//  Created by USER on 24/04/26.
//

import SwiftUI
import SwiftData
struct PreferencesView: View {
    var user: User
    @Environment(\.modelContext) var modelContext
    var body: some View {
        
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
                            user.meals.append(createMeal())
//                            user.numberOfMeals+=1
                        }
                        .tint(Color(.red))
                    }
                }
            
            
            List {
                ForEach(user.meals) { meal in
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
                                            let meal = user.meals[index]
                                            modelContext.delete(meal)
                                            user.meals.remove(at: index)
                                        }
                }
                .listRowSeparator(.hidden)
                
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .scrollIndicators(.hidden)
        }
        
        NavigationLink(destination: RefeicoesView(user: user)){
            Button("Concluir"){
                
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
        return Meal(mealName: "", date: .now, time: .now, status: .pendente)
    }
}

#Preview {

}
