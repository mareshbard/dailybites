//
//  TipsView.swift
//  DailyBites
//
//  Created by Lucas Ibiapina on 18/06/26.
//

import SwiftUI

struct TipsView: View {
    
    @State private var listaDicas: [Tip] = []
        
    var body: some View {
        
        NavigationStack{
            ScrollView{
                VStack{
                    Text("Explore a seleção de dicas e transforme sua rotina")
                    //    .font(Font.custom("PlusJakartaSans-SemiBold", size: 20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    VStack {
                        ForEach(listaDicas) { tip in
                            
                            NavigationLink(destination: TipsContent(dica: tip)){
                                TipsCard(dica: tip)
                                    .ignoresSafeArea()

                            }
                            
                            .foregroundColor(Color(.label))
                            
                        }
                    }
                }
                .padding(15)
                .navigationTitle("Dicas")
                .onAppear {
                    listaDicas = Bundle.main.decode(file: "Tips")
                }
                
            }
            .background(Color.backgroundCor)

        }
        
    }
}


#Preview {
    TipsView()
}
