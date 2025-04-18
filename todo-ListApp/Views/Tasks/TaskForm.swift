//
//  TaskForm.swift
//  todo-ListApp
//
//  Created by Vinaydeep Singh Padda on 2025-04-17.
//

import Foundation
import SwiftUI

struct TaskForm: View {
    @Binding var title: String
    @Binding var notes: String
    @Binding var dueDate: Date
    @Binding var location: String
    @Binding var category: String
    
    var body: some View {
        Form {
            Section(header: Text("Task Details")) {
                TextField("Title", text: $title)
                TextField("Notes (optional)", text: $notes)
                DatePicker("Due Date (optional)", selection: $dueDate, displayedComponents: .date)
            }
            
            Section(header: Text("Additional Info")) {
                TextField("Location (optional)", text: $location)
                TextField("Category (optional)", text: $category)
            }
        }
    }
}
