//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 09/03/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import Foundation
import CoreData

open class CoreDataStack {

    // MARK: - Properties

    private let modelName: String

    // MARK: - Initializer

    public init(modelName: String) {
        self.modelName = modelName
    }

    // MARK: - Core Data stack

    public lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    public lazy var mainContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()

    public func saveContext() {
        guard mainContext.hasChanges else { return }
        do {
            try mainContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
}
