//
//  SplashScreenView.swift
//  DailyBites
//
//  Created by user on 22/04/26.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View{
        VStack{

            VStack{
                Text("Daily")
                Text("Bites")
            }
            .font(.system(size: 80).bold())
            .padding(EdgeInsets(top: 100, leading: -160, bottom: 0, trailing: 0))
 
            Image("AppleSplash")
                .padding(EdgeInsets(top: 110, leading: 0, bottom: 0, trailing: 0))
        }
    }
}

struct SplashView_Preview: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
