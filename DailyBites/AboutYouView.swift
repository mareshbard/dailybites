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
    @State private var meals: [Meal] = []
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

            Button("Próximo"){
                let newUser = User(username: username, numberOfMeals: numberOfMeals, meals: [])
                modelContext.insert(newUser)
            }
            .buttonStyle(.borderedProminent)
            .buttonSizing(.flexible)
            .font(Font.title3)
            .controlSize(.large)
            .tint(.red)
            
        }
        .padding(.horizontal, 24)
        
    }
        
    }


#Preview {
    AboutYouView()
}
//teste
