//
//  PersistanceController.swift
//  LocateMe
//
//  Created by Abdul Mubeen Mohammed on 2025-04-11.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    // Set up the persistent container.
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "LocateMe")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
