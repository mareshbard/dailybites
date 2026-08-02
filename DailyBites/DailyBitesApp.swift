//
//  DailyBitesApp.swift
//  DailyBites
//
//  Created by USER on 22/04/26.
//

import SwiftUI
import SwiftData
import Foundation

@main
struct DailyBitesApp: App {

    let modelContainer: ModelContainer

    init() {
        modelContainer = Self.makeModelContainer()
        Self.backfillMealIdentifiers(in: modelContainer)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(modelContainer)
    }

    /// Cria o container do SwiftData de forma resiliente. Se a store em disco não puder ser aberta
    /// (por exemplo, após uma mudança de schema que a torne incompatível), a store é recriada uma
    /// única vez em vez de a app perder silenciosamente a persistência. Assim qualquer pessoa da
    /// equipe consegue testar no seu próprio device sem que os dados desapareçam a cada atualização.
    private static func makeModelContainer() -> ModelContainer {
        let schema = Schema([LogMeal.self, Meal.self])
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: configuration)
        } catch {
            print("SwiftData store não pôde ser aberta, recriando: \(error.localizedDescription)")
            removeStoreFiles(at: configuration.url)

            do {
                return try ModelContainer(for: schema, configurations: configuration)
            } catch {
                fatalError("Não foi possível criar o ModelContainer: \(error.localizedDescription)")
            }
        }
    }

    /// Preenche com um identificador único as refeições que vieram de uma versão anterior sem `uuid`.
    /// Roda uma única vez após a migração e garante que cada refeição tenha um id estável e distinto,
    /// evitando notificações duplicadas para quem atualiza o app.
    private static func backfillMealIdentifiers(in container: ModelContainer) {
        let context = ModelContext(container)
        let descriptor = FetchDescriptor<Meal>(predicate: #Predicate { $0.uuid == nil })

        guard let mealsWithoutID = try? context.fetch(descriptor), !mealsWithoutID.isEmpty else {
            return
        }

        for meal in mealsWithoutID {
            meal.uuid = UUID()
        }
        try? context.save()
    }

    /// Remove o arquivo da store e seus arquivos auxiliares (-wal e -shm) do SQLite.
    private static func removeStoreFiles(at storeURL: URL) {
        let fileManager = FileManager.default
        let auxiliaryURLs = [
            storeURL,
            storeURL.deletingPathExtension().appendingPathExtension("store-wal"),
            storeURL.deletingPathExtension().appendingPathExtension("store-shm")
        ]

        for url in auxiliaryURLs where fileManager.fileExists(atPath: url.path) {
            try? fileManager.removeItem(at: url)
        }
    }
}
