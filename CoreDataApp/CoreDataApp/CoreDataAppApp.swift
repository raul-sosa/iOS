//
//  CoreDataAppApp.swift
//  CoreDataApp
//
//  Created by Raul Sosa on 01/11/25.
//

import SwiftUI
import CoreData

@main
struct CoreDataAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
