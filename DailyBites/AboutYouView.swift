//
//  AboutYouView.swift
//  DailyBites
//
//  Created by USER on 22/04/26.
//

import SwiftUI

struct AboutYouView: View {
    var body: some View {
        VStack{
            Image("AppleAboutYou")
                .padding(20)
                .font(.largeTitle)
            Text("Sobre você")
                .font(.largeTitle)
            Text("Qual é o seu nome?")
                TextField("Nome", text: .constant(""))
                
                .textFieldStyle(OutlinedTextFieldStyle())
            

            Text("Quantas refeições você faz por dia?")
                TextField("Escolha a quantidade", text: .constant(""))
                
                .textFieldStyle(OutlinedTextFieldStyle())
            }
            
        }
        
    }


#Preview {
    AboutYouView()
}
