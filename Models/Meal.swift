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
    var name: String
    var time: Date = Date() //Horário que a pessoa cadastrou a refeicao
    var logs: [LogMeal]
    var isFixed: Bool = false
    init(name: String, logs: [LogMeal], time: Date, isFixed: Bool) {
        self.name = name
        self.logs = logs
        self.time = time
        self.isFixed = isFixed
    }
}


@Model
class LogMeal: Identifiable {
    
    var id: UUID = UUID()
    var ref: Meal?
    var date: Date = Date() //Data que foi feita a refeicao
    var imageData: Data?
    var durationMeal: Int = 0 //Tempo que a pessoa levou para comer
    var status: Status = Status.pendente
    var descriptionMeal: String = ""
    var emotion: Mood = Mood.normal
    
    init(ref: Meal,
         date: Date,
         imageData: Data? = nil,
         durationMeal: Int,
         status: Status,
         descriptionMeal: String,
         emotion: Mood
    ) {
        self.ref = ref
        self.date = date
        self.status = status
        self.imageData = imageData
        self.durationMeal = durationMeal
        self.descriptionMeal = descriptionMeal
        self.emotion = emotion
    }
    
    var image: UIImage? {
        imageData.flatMap{
            UIImage(data: $0)
        }
    }
    var color: Color {
        switch status {
        case .pendente:
            return .gray
        case .atrasado:
            return .laranjaAtrasado
        case .pontual:
            return .verdePontual
        case .pulou:
            return .vermelhoDailyBites
        }
    }
}


