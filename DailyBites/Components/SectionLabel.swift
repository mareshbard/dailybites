//
//  SectionLabel.swift
//  DailyBites
//
//  Created by Yohane Cavalcante on 08/06/26.
//

import SwiftUI

struct SectionLabel: View {
    
    let title: String
    let required: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            Text(title)
            if required {
                Text("*")
                    .foregroundStyle(Color(.red))
            }
        }
    }
}
