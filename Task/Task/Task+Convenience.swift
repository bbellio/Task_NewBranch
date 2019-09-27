//
//  Task+Convenience.swift
//  Task
//
//  Created by Bethany Wride on 9/25/19.
//  Copyright © 2019 Bethany Wride. All rights reserved.
//

import Foundation
import CoreData

extension Task {
    convenience init(name: String, notes: String, due: Date, isComplete: Bool = false, moc: NSManagedObjectContext = CoreDataStack.context) {
        // Could also be super.init?
        self.init(context: moc)
        self.name = name
        self.notes = notes
        self.due = due
        self.isComplete = isComplete
    }
}
