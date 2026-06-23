//
//  TipsType.swift
//  DailyBites
//
//  Created by Lucas Ibiapina on 18/06/26.
//
//

import SwiftUI
import Foundation
import Playgrounds

struct TipSection: Codable {
    let title: String
    let description: String
}

struct Tip: Codable, Identifiable {
    let id: UUID = UUID()
    let tip, title, information, image: String
    let tipSection: [TipSection]
    static let listaDicas: [Tip] = Bundle.main.decode(file: "Tips")
    
}

extension Bundle {
    func decode<T: Decodable>(file: String) -> T {
        
        guard let url = self.url(forResource: file, withExtension: "json") else {
            fatalError("Não foi possível encontrar \(file) no projeto.")
        }
        print("Encontrou o json")
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Não foi possível carregar \(file) do projeto.")
        }
        print("Carregou o Data do json")
        
        let decoder = JSONDecoder()
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Falha ao decodificar \(file). Verifique se o JSON combina com sua Struct.")
        }
        
        return loadedData
    }
}

#Playground {
//    let json = """
//            {
//                "tip": "Teste",
//                "title": "Teste",
//                "information": "Teste",
//                "tipSection" : [
//                    {
//                        "title": "Teste",
//                        "description": "Teste"
//                    },
//                ]
//            }
//        """
//    let jsonData = json.data(using: .utf8)!
//    let blogPost: Tip = try! JSONDecoder().decode(Tip.self, from: jsonData)
    
    
    
//    guard let url = Bundle.main.url(forResource: "Tips", withExtension: "json") else {
//        fatalError("Não foi possível encontrar \("Tips.json") no projeto.")
//    }
//    print("Encontrou o json")
//
//    guard let data = try? Data(contentsOf: url) else {
//        fatalError("Não foi possível carregar \("Tips.json") do projeto.")
//    }
//
//    print("Carregou o Data do json")
//
//    let decoder = JSONDecoder()
//
//    guard let loadedData = try? decoder.decode(Tip.self, from: data) else {
//        fatalError("Falha ao decodificar \("Tips.json"). Verifique se o JSON combina com sua Struct.")
//    }
    
    let result: [Tip] = Bundle.main.decode(file: "Tips")
    
//    do {
//        try decoder.decode(Tip.self, from: data)
//    } catch {
//        print(error)
//    }

    
}
