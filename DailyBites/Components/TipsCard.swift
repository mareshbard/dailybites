//
//  TipsCard.swift
//  DailyBites
//
//  Created by Lucas Ibiapina on 18/06/26.
//

import SwiftUI

struct TipsCard: View {
    let dica: Tip
    
    var body: some View {
        
        VStack{
            VStack {
                Text(dica.tip)
                    .font(.headline)
                    .frame(alignment: .leading)
                Text(dica.title)
                    .font(.title3)
                    .frame(alignment: .leading)
            }
            .frame(maxWidth: .infinity)
            .background(Color(.systemBackground))
        }
        
        
    }
}

//#Preview {
//    
//    TipsCard()
//}
