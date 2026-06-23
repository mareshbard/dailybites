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
                return .roxoAcao
            case .comportamento:
                return .orange
            case .consciencia:
                return .red
            case .habito:
                return .green
            case .bemestar:
                return .blue
            }
        }
    }
    
    var body: some View {
        
        HStack{
            VStack {
                Text(dica.tip)
                    .padding(10)
                    .font(.headline)
                    .frame(maxWidth: .infinity ,alignment: .leading)
                    .foregroundStyle(Color(typeOfTip(rawValue: dica.tip)?.color ?? Color.black))
                Spacer()
                
                Text(dica.title)
                    .font(.body)
                    .frame(maxWidth: .infinity ,alignment: .leading)
                    .padding(10)
            }
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.leading)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .padding(10)
        }
        .background(Color("amareloBackground"))
        .cornerRadius(10)


            
    }
}

//#Preview {
//    TipsCard()
//}
