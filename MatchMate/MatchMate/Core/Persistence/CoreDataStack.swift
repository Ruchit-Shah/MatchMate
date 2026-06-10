//
//  CoreDataStack.swift
//  MatchMate
//
//  Created by Ruchit on 10/06/26.
//

import CoreData
import Foundation
import os

protocol CoreDataStackProtocol: AnyObject {
    var viewContext: NSManagedObjectContext { get }
    func newBackgroundContext() -> NSManagedObjectContext
}

final class CoreDataStack: CoreDataStackProtocol {
    static let modelName = "MatchMate"

    private let container: NSPersistentContainer
    private let logger = Logger(subsystem: "com.matchmate", category: "CoreDataStack")

    var viewContext: NSManagedObjectContext {
        container.viewContext
    }

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: CoreDataStack.modelName)

        if inMemory {
            let description = NSPersistentStoreDescription()
            description.url = URL(fileURLWithPath: "/dev/null")
            container.persistentStoreDescriptions = [description]
        }

        container.loadPersistentStores { [logger] _, error in
            if let error {
                logger.error("Failed to load persistent store: \(error.localizedDescription, privacy: .public)")
            }
        }

        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    func newBackgroundContext() -> NSManagedObjectContext {
        let context = container.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }
}
