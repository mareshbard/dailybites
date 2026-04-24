//
//  SwiftUIView.swift
//  DailyBites
//
//  Created by user on 24/04/26.
//

import SwiftUI

struct SwiftUIView: View {
    
    @State private var showaddmeal: Bool = false
    
    var body: some View {
        
        NavigationStack {
            VStack {
                Text("Hello, World!")
            }
            .toolbar{
                ToolbarItem(placement: .primaryAction){
                    Button{
                        showaddmeal = true
                    } label: {
                        Image(systemName: "plus")
                    }.sheet(isPresented: $showaddmeal){
                        AddMealView()
                    }
                }
            }
            
        }
        
    }
}

    

#Preview {
    SwiftUIView()
}
