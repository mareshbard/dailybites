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
class Meal {
    var mealName: String = ""
    var date: Date = Date()
    var time: Date = Date()
    var image: Image? = nil
    var status: Status = Status.pendente
}


