//
//  TipsType.swift
//  DailyBites
//
//  Created by Lucas Ibiapina on 18/06/26.
//
//

import SwiftUI
import Foundation

struct Tip: Codable {
    let tip, title, information : String
    static let listaDicas: [Tip] = Bundle.main.decode(file: "Tips.json")
}

extension Bundle {
    func decode<T: Decodable>(file: String) -> T {
        
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Não foi possível encontrar \(file) no projeto.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Não foi possível carregar \(file) do projeto.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Falha ao decodificar \(file). Verifique se o JSON combina com sua Struct.")
        }
        
        return loadedData
    }
}
