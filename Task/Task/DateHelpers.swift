//
//  DateHelpers.swift
//  Task
//
//  Created by Bethany Wride on 9/25/19.
//  Copyright © 2019 Bethany Wride. All rights reserved.
//

import Foundation

extension Date {
    func stringValue() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
}
