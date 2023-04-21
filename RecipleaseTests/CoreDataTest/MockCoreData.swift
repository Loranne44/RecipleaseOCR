//
//  MockCoreData.swift
//  RecipleaseTests
//
//  Created by Loranne Joncheray on 28/03/2023.
//
@testable import Reciplease
import Foundation
import CoreData

final class MockCoreDataStack: CoreDataStack {
    
    override var persistentContainer: NSPersistentContainer {
        get {
            return _persistentContainer
        }
        set {
            _persistentContainer = newValue
        }
    }
    
    lazy var _persistentContainer: NSPersistentContainer = {
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        
        let container = NSPersistentContainer(name: "Reciplease")
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
}
