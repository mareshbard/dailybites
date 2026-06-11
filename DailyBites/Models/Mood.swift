import Charts
import Foundation
import SwiftUI

enum Mood: String, CaseIterable, Codable, Plottable{
    case verysad = "😢"
    case sad = "😟"
    case neutral = "😐"
    case happy = "🙂"
    case veryhappy = "😄"
    
    var id: Self { self }
    
    var content: Image {
        switch self {
        case .verysad: return Image("muito-triste")
        case .sad: return Image("triste")
        case .neutral: return Image("neutro")
        case .happy: return Image("feliz")
        case .veryhappy: return Image("muito-feliz")
        }
    }
    
    var title: String {
        switch self {
        case .verysad: return "Muito triste"
        case .sad: return "Triste"
        case .neutral: return "Neutro"
        case .happy: return "Feliz"
        case .veryhappy: return " Muito feliz"
        }
    }
    var description: String {
        switch self {
        case .verysad: return "Maçã muito triste"
        case .sad: return "Maçã triste"
        case .neutral: return "Maçã neutra"
        case .happy: return "Maça feliz"
        case .veryhappy: return " Maçã muito feliz"
        }
    }
    static func fromTitle (_ title: String) -> Mood? {
        Mood.allCases.first{$0.title == title}
    }
}

