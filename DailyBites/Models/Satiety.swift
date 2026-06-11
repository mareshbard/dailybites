//
//  Satiety.swift
//  DailyBites
//
//  Created by Yohane Cavalcante on 07/06/26.
//
import Charts
import Foundation

enum Satiety: String, CaseIterable, Codable, Plottable {
    case muitaFome
    case fome
    case satisfeito
    case cheio
    case muitoCheio
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .muitaFome: return "Muita fome"
        case .fome: return "Fome"
        case .satisfeito: return "Satisfeito"
        case .cheio: return "Cheio"
        case .muitoCheio: return "Muito cheio"
        }
    }
    static func fromTitle (_ title: String) -> Satiety? {
        Satiety.allCases.first{$0.title == title}
    }
}
