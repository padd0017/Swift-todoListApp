//
//  Tasks.swift
//  todo-ListApp
//
//  Created by Vinaydeep Singh Padda on 2025-04-15.
//

import Foundation
import SwiftData

@Model
class Tasks: ObservableObject {
    var title: String
    var notes: String?
    var dueDate: Date?
    var location: String?
    var category: String?
    var isDone: Bool = false
    var firebaseId: String? 
    
    init(title: String, notes: String? = nil, dueDate: Date? = nil, location: String? = nil, category: String? = nil, isDone: Bool) {
        self.title = title
        self.notes = notes
        self.dueDate = dueDate
        self.location = location
        self.category = category
        self.isDone = isDone
    }
}
