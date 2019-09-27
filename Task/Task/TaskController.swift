//
//  TaskController.swift
//  Task
//
//  Created by Bethany Wride on 9/25/19.
//  Copyright © 2019 Bethany Wride. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    // Singleton
    static let sharedInstance = TaskController()
    
    //     Local source of truth
    //    var tasks: [Task] {
    //        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
    //        return (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
    //    }
    
    var fetchedResultsController: NSFetchedResultsController<Task>
    init() {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let isCompleteSort = NSSortDescriptor(key: "isComplete", ascending: true)
        let dueSort = NSSortDescriptor(key: "due", ascending: true)
        fetchRequest.sortDescriptors = [isCompleteSort, dueSort]
        let resultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "isComplete", cacheName: nil)
        fetchedResultsController = resultsController
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Error in Fetch Controller: \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
    // CRUD
    // Create
    func addTask(with name: String, notes: String, due: Date) {
        _ = Task(name: name, notes: notes, due: due)
        saveToPersistentStore()
    }
    
    // Update
    func update(task: Task, name: String, notes: String?, due: Date?) {
        task.name = name
        task.notes = notes
        task.due = due
        saveToPersistentStore()
    }
    
    // Remove
    func remove(task: Task) {
        CoreDataStack.context.delete(task)
        saveToPersistentStore()
    }
    
    // Toggle
    func toggleIsCompleteFor(task: Task) {
        task.isComplete = !task.isComplete
        saveToPersistentStore()
    }
    
    // Save
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
}


