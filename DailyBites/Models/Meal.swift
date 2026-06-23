import SwiftUI
import SwiftData
import Foundation

@Model
class Meal {
    var name: String
    var time: Date = Date() //Horário que a pessoa cadastrou a refeicao
    var logs: [LogMeal]
    var isFixed: Bool = false
//    var repeatDays: [Int] = []
    init(name: String, logs: [LogMeal], time: Date, isFixed: Bool, repeatDays: [Int] = [] ) {
        self.name = name
        self.logs = logs
        self.time = time
        self.isFixed = isFixed
//        self.repeatDays = repeatDays
    }
}


@Model
class LogMeal: Identifiable {
    
    var id: UUID = UUID()
    var ref: Meal?
    var date: Date = Date() //Data que foi feita a refeicao
    var satiety: Satiety = Satiety.satisfeito
    var imageData: Data?
    var durationMeal: Int = 0 //Tempo que a pessoa levou para comer
    var status: Status = Status.pendente
    var descriptionMeal: String = ""
    var emotion: Mood = Mood.neutral
    
    init(ref: Meal,
         date: Date,
         satiety: Satiety,
         imageData: Data? = nil,
         durationMeal: Int,
         status: Status,
         descriptionMeal: String,
         emotion: Mood,
    ) {
        self.ref = ref
        self.date = date
        self.satiety = satiety
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
            return .pendenteTag
        case .atrasado:
            return .atrasadaTag
        case .pontual:
            return .pontualTag
        case .pulou:
            return .nãoRealizadaTag
        }
    }
    
    var fontColor: Color {
        switch status {
        case .pendente:
            return .corPendente
        case .atrasado:
            return .corAtrasado
        case .pontual:
            return .corPontual
        case .pulou:
            return .corNaoRealizada
        }
    }
}


