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
    var date: Date = Date() //Data que foi feita a refeicao
    var time: Date = Date() //Horário que a pessoa cadastrou a refeicao
    var imageData: Data?
    var durationMeal: Int = 0 //Tempo que a pessoa levou para comer
    var status: Status = Status.pendente
    var descriptionMeal: String = ""
    var emotion: Mood = Mood.normal
    
    init(
        mealName: String,
        date: Date,
        time: Date,
        imageData: Data? = nil,
        durationMeal: Int,
        status: Status,
        descriptionMeal: String,
        emotion: Mood
    ) {
        self.mealName = mealName
        self.date = date
        self.time = time
        self.imageData = imageData
        self.durationMeal = durationMeal
        self.status = status
        self.descriptionMeal = descriptionMeal
        self.emotion = emotion
    }
    
    var image: UIImage? {
        imageData.flatMap{
            UIImage(data: $0)
        }
    }
}


