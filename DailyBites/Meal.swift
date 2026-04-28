//
//  Meal.swift
//  DailyBites
//
//  Created by user on 23/04/26.
//

import SwiftUI
import SwiftData
import Foundation

@Model
class Meal: Identifiable {
    var id: UUID = UUID()
    var mealName: String = ""
    var date: Date = Date()
    var time: Date = Date()
    var imageData: Data?
    var status: Status = Status.pendente
    
    init(mealName: String, date: Date, time: Date, imageData: Data? = nil, status: Status) {
        self.mealName = mealName
        self.date = date
        self.time = time
        self.imageData = imageData
        self.status = status
    }
    
    var image: UIImage? {
        imageData.flatMap{
            UIImage(data: $0)
        }
    }
}


