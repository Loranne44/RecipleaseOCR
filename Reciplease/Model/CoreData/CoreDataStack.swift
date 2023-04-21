//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by Loranne Joncheray on 08/02/2023.
//

import Foundation
import CoreData

open class CoreDataStack {
    
    // MARK: - Properties
    var viewContext : NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Reciplease")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Methods
    func saveContext() {
        guard viewContext.hasChanges else {
            return
        }
        do {
            try viewContext.save()
        } catch let error as NSError {
            print("\(error)")
        }
    }
}
