//
//  Status.swift
//  DailyBites
//
//  Created by user on 23/04/26.
//
import Charts

enum Status: String, CaseIterable, Codable, Plottable {
    case pontual
    case atrasado
    case pulou
    case pendente
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .pontual: return "Realizada"
        case .atrasado: return "Realizada com atraso"
        case .pulou: return "Não realizada"
        case .pendente: return "Pendente"

        }
    }
    static func fromTitle (_ title: String) -> Status? {
        Status.allCases.first{$0.title == title}
    }
}


