//
//  Status.swift
//  DailyBites
//
//  Created by user on 23/04/26.
//

enum Status: String, CaseIterable, Codable {
    case pontual
    case atrasado
    case pulou
    case pendente
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .pontual: return "Pontual"
        case .atrasado: return "Atrasado"
        case .pulou: return "Não realizada"
        case .pendente: return "Pendente"
        }
    }
}


