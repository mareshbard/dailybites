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
                
                RoundedRectangle( cornerRadius: 10)
                
                    .fill(.clear)
                    .stroke(Color.red, style: StrokeStyle(lineWidth: 2))
                    .padding(10)
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
