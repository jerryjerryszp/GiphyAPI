//
//  CoreDataManager.swift
//  GiphyAPI
//
//  Created by Jerry Shi on 2020-09-16.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    // MARK: Core Data stack
    private init() {}

    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GiphyAPI")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // MARK: Core Data Saving support
    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("saved")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

