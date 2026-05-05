//
//  ContentView.swift
//  DailyBites
//
//  Created by USER on 22/04/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @AppStorage("username") var username = ""
    @State private var showSplash = true
    @AppStorage("firstUse") var firstUse: Bool = true
    var body: some View {
        ZStack{
            if showSplash {
                SplashScreenView()
                    .transition(.opacity)
                    .animation(
                        .easeOut(duration: 0.5)
                    )
            } else {
                if (username != "") {
                    HomeView()
                        .onAppear {
                        firstUse = false
                    }
                } else {
                    AboutYouView()
                        .font(.largeTitle)
                }
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
  //  ContentView()
}

