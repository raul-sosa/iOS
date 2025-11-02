//
//  PersistenceController.swift
//  CoreDataApp
//
//  Created by Raul Sosa on 01/11/25.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "Modelo")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("No se pudo cargar Core Data: \(error)")
            }
        }
    }
}
