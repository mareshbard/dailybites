//
//  TipsCard.swift
//  DailyBites
//
//  Created by Lucas Ibiapina on 18/06/26.
//

import SwiftUI

struct TipsCard: View {
    let dica: Tip
    
    enum typeOfTip: String, Identifiable, CaseIterable {
        case nutricao = "NUTRIÇÃO"
        case comportamento = "COMPORTAMENTO"
        case consciencia = "CONSCIÊNCIA"
        case habito = "HÁBITO"
        case bemestar = "BEM-ESTAR"
        
        var id: Self { self }
        
        var color: Color {
            switch self {
            case .nutricao:
                return .roxoTip
            case .comportamento:
                return .comportamento
            case .consciencia:
                return .consciencia
            case .habito:
                return .habito
            case .bemestar:
                return .bemestar
            }
        }
    }
    
    var body: some View {
        
        HStack{
            VStack {
                Text(dica.tip)
                    .padding(10)
                    .font(.footnote.bold())
                    .frame(maxWidth: .infinity ,alignment: .leading)
                    .foregroundStyle(Color(typeOfTip(rawValue: dica.tip)?.color ?? Color.black))
                   // .font(Font.custom("PlusJakartaSans-Bold", size: 10))
            //    Spacer()
                
                Text(dica.title)
                    .font(.body)
                    .frame(maxWidth: .infinity ,alignment: .leading)
                    .padding(.leading, 10)
                    .padding(.bottom, 10)
            }
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.leading)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .padding(10)
        }
        .background(Color.yellowTip)
        .cornerRadius(10)


            
    }
}

//#Preview {
//    TipsCard()
//}
