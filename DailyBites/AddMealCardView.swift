//
//  AddMealCardView.swift
//  DailyBites
//
//  Created by USER on 24/04/26.
//

import SwiftUI
import SwiftData

struct AddMealCardView: View {
    @State var mealName: String = ""
    @State var time: Date = Date()
    
    var meal: Meal
 
    var body: some View {
   
            HStack(alignment: .center, spacing: 16) {
                //pra poder atualizar o objeto do sd em tempo real
                @Bindable var meal = meal
                
                ZStack(alignment: .center){
                    Circle()
                        .fill(Color("LightRed"))

                        Image(systemName: "fork.knife")
                            .resizable()
                            .frame(width: 24, height: 30)
                            .foregroundStyle(Color.red)
                }
                .frame(width: 60, height: 60, alignment: .center)
                
                VStack(alignment: .leading, spacing: 10){
                    Text("Nome da refeição")
                        .frame(width: 147, alignment: .leading)
                        .font(Font.body)
                    TextField("Nome", text: $meal.mealName)
                        .font(Font.body)
                        .padding(10)
                        .frame(width: 147, height: 34)
                        .background(Color("FillGray"))
                        .cornerRadius(100)
                }
                VStack{
                    Text("Horário")
                        .font(Font.body)
                    DatePicker("Selecione a data", selection: $meal.time, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .tint(Color("VermelhoDailyBites"))
                }
            }
    }
}

#Preview {
  //  PreferencesView()
}
