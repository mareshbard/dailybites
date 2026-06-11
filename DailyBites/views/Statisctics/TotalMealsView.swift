//
//  TotalMealsView.swift
//  DailyBites
//
//  Created by Lucas Ibiapina on 08/06/26.
//

import SwiftUI

struct TotalMealsView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction ) {
                        
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                    
                    ToolbarItem(placement: .title){
                        Text("Total de refeições")
                    }
        }
        
        }
    }
}

#Preview {
    TotalMealsView()
}
