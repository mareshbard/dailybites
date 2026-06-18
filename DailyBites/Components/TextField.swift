//
//  TextField.swift
//  DailyBites
//
//  Created by USER on 22/04/26.
//

import SwiftUI

struct OutlinedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(15)
            .overlay {
                
                RoundedRectangle( cornerRadius: 12)
                
                    .fill(.clear)
                    .stroke(Color("RoxoStroke"), style: StrokeStyle(lineWidth: 2))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            }
    }
}

struct OutlinedTextFieldStyleDescription: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .overlay {
                
                RoundedRectangle( cornerRadius: 12)
                
                    .fill(.clear)
                    .stroke(Color.red, style: StrokeStyle(lineWidth: 0.5))
                    .frame(maxWidth: .infinity, maxHeight: 300, alignment: .leading)
            }
    }
}


