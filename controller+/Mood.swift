enum Mood: String, CaseIterable, Codable{
    case verysad = "😢"
    case sad = "😟"
    case normal = "😐"
    case happy = "🙂"
    case veryhappy = "😄"
}

enum MoodDescription: String, CaseIterable {
    case muitotriste = "Muito Triste"
    case triste = "Triste"
    case netro = "Neutro"
    case feliz = "Feliz"
    case muitofeliz = "Muito Feliz"
}

enum Satiety: String, CaseIterable {
    case muitaFome = "Muita Fome"
    case Fome = "Fome"
    case Satisfeito = "Satisfeito"
    case Cheio = "Cheio"
    case muitoCheio = "Muito Cheio"
    
    var id: Self { self }
    
    var backgroundSatiety: String {
        switch self {
        case .muitaFome:
            return "Yellow"
        case .Fome:
            return "Yellow"
        case .Satisfeito:
            return "purple"
        case .Cheio:
            return "purple"
        case .muitoCheio:
            return "purple"
        }
    }

}


