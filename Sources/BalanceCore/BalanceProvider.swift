//
//  BalanceProvider.swift
//  QRIS App
//
//  Created by Ariesta APP on 25/01/24.
//

import Foundation
import CoreData

public class BalanceProvider {
    public static let shared = BalanceProvider()
    private let name = "BalanceDataModel"
    private lazy var persistentContainer: NSPersistentContainer = {
        let url = Bundle.module.url(forResource: self.name, withExtension: "momd")
        let mom = NSManagedObjectModel(contentsOf: url!)
        let container = NSPersistentContainer(name: self.name, managedObjectModel: mom!)
        container.loadPersistentStores { _, err in
            guard err == nil else {
                fatalError("Unresolved Error: \(String(describing: err))")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil
        return container
    }()
    
    
    
    public func newTaskContext() -> NSManagedObjectContext {
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.undoManager = nil
        
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return taskContext
    }
    
    
}
