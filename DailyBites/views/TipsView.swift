//
//  TipsView.swift
//  DailyBites
//
//  Created by Lucas Ibiapina on 18/06/26.
//

import SwiftUI

struct TipsView: View {
    
    var body: some View {
        
        NavigationStack{
            ScrollView{
                VStack{
                    Text("Explore a seleção de dicas e transforme sua rotina")
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                        }
                        
                    }
                .navigationTitle("Dicas")

        }
        .padding(15)

                
                
                
            }
        }


#Preview {
    TipsView()
}
