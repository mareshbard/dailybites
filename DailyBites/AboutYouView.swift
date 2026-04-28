//
//  AboutYouView.swift
//  DailyBites
//
//  Created by USER on 22/04/26.
//

import SwiftUI
import SwiftData

struct AboutYouView: View {
    @State private var username: String = ""
    @State private var numberOfMeals: Int = 1
    @State private var meals: [Meal] = [Meal(mealName: "", date: .now, time: .now, status: .pendente)]
    @State private var selectedNumber = 1
    let range = 1...10
    
    @Environment(\.modelContext)
    private var modelContext
    
    
    var body: some View {
        NavigationStack{
        
            
            VStack{
                Image("AppleAboutYou")
                    .padding(25)
                    .font(.largeTitle)
                Text("Sobre você")
                    .font(.largeTitle)
                    .padding(15)
                
                Text("Qual é o seu nome?")
                    .font(Font.title2)
                    .frame(maxWidth: .infinity, maxHeight: 15, alignment: .leading)
                
                TextField("Nome", text: $username)
                    .font(Font.body)
                    .textFieldStyle(OutlinedTextFieldStyle())
                
                
                Text("Quantas refeições você faz por dia?")
                    .font(Font.title2)
                    .frame(maxWidth: .infinity, maxHeight: 15, alignment: .leading)
                
                
                HStack{
                    Text("Escolha a quantidade")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(Font.body)
                        .foregroundStyle(.tertiary)
                    Picker("Escolha a quantidade", selection: $numberOfMeals){
                        ForEach(range, id: \.self) {number in
                            Text("\(number)").tag(number)
                        }
                        .onChange(of: numberOfMeals) { newValue in
                            createEmptyMeals()
                        }
                    }
                    .tint(Color.red)
                }
                .padding(20)
                .overlay {
                    
                    RoundedRectangle( cornerRadius: 12)
                        .fill(.clear)
                        .stroke(Color.red, style: StrokeStyle(lineWidth: 0.5))
                        .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
            }
            }
            
            Spacer()
            NavigationLink(destination: PreferencesView(user: User(username: username, meals: meals))){
                Button("Próximo"){
                    let newUser = User(username: username, meals: meals)
                    modelContext.insert(newUser)
                }
            }
            .buttonStyle(.borderedProminent)
            .buttonSizing(.flexible)
            .font(Font.title3)
            .controlSize(.large)
            .tint(.red)
            .foregroundColor(Color(.white))
            
        }
        .padding(.horizontal, 24)
        
    }
    
    func createEmptyMeals() {
        var tempMeals: [Meal] = []
        for  _ in 0..<numberOfMeals {
            tempMeals.append(Meal(mealName: "", date: .now, time: .now, status: .pendente))
        }
        meals = tempMeals
    }
        
    }


#Preview {
    AboutYouView()
}
