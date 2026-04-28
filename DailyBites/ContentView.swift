//
//  ContentView.swift
//  DailyBites
//
//  Created by USER on 22/04/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    @State private var showSplash = true
    var body: some View {
        ZStack{
            if showSplash {
                SplashScreenView()
                    .transition(.opacity)
                    .animation(
                        .easeOut(duration: 0.5)
                    )
            } else {
                AboutYouView()
                    .font(.largeTitle)
                }
            }
        
        .onAppear{
            DispatchQueue.main
                .asyncAfter(deadline: .now() + 1)
                {
                    withAnimation {
                        self.showSplash = false
                    }
                }
        }
        
    }
}

#Preview {
    ContentView()
}

