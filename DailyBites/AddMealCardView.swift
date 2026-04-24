//
//  AddMealCardView.swift
//  DailyBites
//
//  Created by USER on 24/04/26.
//

import SwiftUI

struct AddMealCardView: View {
    
    @State var date: Date = Date()
    @State var nameMeal: String = ""
    var body: some View {
   
            HStack(alignment: .center, spacing: 16) {
                
                ZStack(alignment: .center){
                    Circle()
                        .fill(Color("LightRed"))
                    
                    Button(action:
                            {
                        print("ss");
                    }
                    ) {
                        Image(systemName: "face.smiling")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .tint(Color.red)
                }
                
                .frame(width: 60, height: 60, alignment: .center)
                
                VStack(alignment: .leading, spacing: 10){
                    Text("Nome da refeição")
                        .frame(width: 147, alignment: .leading)
                    TextField("Nome", text: $nameMeal)
                        .font(Font.body)
                        .padding(10)
                        .frame(width: 147, height: 34)
                        .background(Color("FillGray"))
                        .cornerRadius(100)
                }
                VStack{
                    Text("Horário")
                    DatePicker("aa", selection: $date, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .tint(Color("VermelhoDailyBites"))
                    //  TextField()
                }
                
            
            
            
            
            
        }
   
    }
}

#Preview {
    AddMealCardView()
}
