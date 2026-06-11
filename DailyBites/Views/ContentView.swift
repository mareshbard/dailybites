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
    @SceneStorage("selectedTab") private var selectedTabIndex: Int = 0
    var body: some View {
        ZStack{
      
                if (username != "") {
                    TabBar()
                } else {
                    AboutYouView()
                    
                        .font(.largeTitle)
                  
                }
            
        }
        
    }
}

#Preview {
  //  ContentView()
}

