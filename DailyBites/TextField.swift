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
           .padding(20)
            .overlay {
                
                RoundedRectangle( cornerRadius: 12)
                
                    .fill(.clear)
                    .stroke(Color.red, style: StrokeStyle(lineWidth: 0.5))
                    .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
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
    


//struct OutlinedTextFieldStyle: TextFieldStyle {
//    
//    @State var icon: Image?
//    
//    func _body(configuration: TextField<Self._Label>) -> some View {
//        HStack {
//            if icon != nil {
//                icon
//                    .foregroundColor(Color(UIColor.systemGray4))
//            }
//            configuration
//        }
//        .padding()
//        .overlay {
//            RoundedRectangle(cornerRadius: 8, style: .continuous)
//                .stroke(Color(UIColor.systemGray4), lineWidth: 2)
//        }
//    }
//}
