//
//  LogRecorded.swift
//  DailyBites
//
//  Created by Leticia Gomes on 12/06/26.
//

import SwiftUI

struct LogRecorded: View {
    var log: LogMeal
    var body: some View {
        HStack {
            if let image = log.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            } else {
                Image(decorative: "purple-pattern")
            }
            
        }
        .padding(10)
    }
}

#Preview {
  //  LogRecorded()
}
