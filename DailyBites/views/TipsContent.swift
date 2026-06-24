//
//  TipsContent.swift
//  DailyBites
//
//  Created by Lucas Ibiapina on 23/06/26.
//

import SwiftUI

struct TipsContent: View {
    
    var dica: Tip
    
    var body: some View {
        NavigationStack{
            ScrollView{
                
                Image(dica.image)
                    .padding(.top, 70)
                    .padding(30)
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity)
                    .background(Color("BackgroundAboutYou"))
                    .clipShape(RoundedRectangle(cornerRadius: 35))
                    .ignoresSafeArea()
                    .accessibilityHidden(true)
                
                VStack(spacing: 10) {
                    
                    Text("Fonte: Ministério da Saúde")
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    Spacer()
                    
                    Text(dica.title)
                        .font(.title3.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    Text(dica.information)
                        .font(.body)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ForEach(0...dica.tipSection.count-1, id: \.self) { index in
                        Spacer()
                        
                        Text(dica.tipSection[index].title)
                            .font(.title3.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        
                        Text(dica.tipSection[index].description)
                            .font(.body)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                }
                .padding(15)
               // .navigationTitle(dica.tip)
                .frame(maxWidth: .infinity, alignment: .leading)
               
                
               
            }
           // .padding(15)
           // .scrollContentBackground(.hidden)
            .ignoresSafeArea()
          //  .background(Color.backgroundCor)
        }


        
    }
}

#Preview {
  //  TipsContent(dica: Tip)
}
