//
//  PreferencesView.swift
//  DailyBites
//
//  Created by USER on 24/04/26.
//

import SwiftUI

struct PreferencesView: View {
    let range = 1...10
    var body: some View {

        NavigationStack {
            VStack{
                Text("Refeições")
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Escolha o nome e horário de suas refeições")
                    .frame(maxWidth: .infinity, alignment: .leading)
        
            }
            .padding(.horizontal, 24)
           // .navigationTitle("Refeições")
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Finalizar", systemImage: "plus") {
                           
                        }
                        .tint(Color(.red))
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Voltar", systemImage: "chevron.left") {
                           
                        }

                    }
                }
            List {
                ForEach(range, id: \.self) { i in
                    ZStack {
                        RoundedRectangle( cornerRadius: 12)
                            .fill(.clear)
                            .stroke(Color.red, style: StrokeStyle(lineWidth: 0.5))
                        AddMealCardView()
                            .padding(.vertical, 10)
                       
                    }
                    .padding(-8)
                    
                    
                }
                
                
                .onDelete{ offsets in
                    for index in offsets {
                        
                    }}
                .listRowSeparator(.hidden)
                
            }
 
            .scrollContentBackground(.hidden)
        }
        
        
    }
}

#Preview {
    PreferencesView()
}
