//
//  Usuário.swift
//  DailyBites
//
//  Created by user on 23/04/26.
//

import Foundation
import SwiftUI
import SwiftData


@Model
class User {
    var username: String = ""
    var numberOfMeals: Int = 1
    var meals: [Meal] = []
}
