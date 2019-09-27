//
//  CoreDataStack.swift
//  Task
//
//  Created by Bethany Wride on 9/25/19.
//  Copyright © 2019 Bethany Wride. All rights reserved.
//

import Foundation
import CoreData

enum CoreDataStack {
    
    static let container: NSPersistentContainer = {
        // Gets name of app, pass in key and get an object out
        let appName = Bundle.main.object(forInfoDictionaryKey: (kCFBundleNameKey as String)) as! String
        // init a new persistent container with the above app name - make sure to add the name in the String
        let container = NSPersistentContainer(name: "Task")
        // load persistent store is a function of nspersistent container; if it doesn't load it will pass an error
        container.loadPersistentStores() { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    static var context: NSManagedObjectContext { return container.viewContext }
}

