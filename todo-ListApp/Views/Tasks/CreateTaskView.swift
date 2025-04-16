//
//  CreateTaskView.swift
//  todo-ListApp
//
//  Created by Vinaydeep Singh Padda on 2025-04-16.
//

import Foundation
import SwiftUI
import SwiftData


struct CreateTaskView:  View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var authManager: AuthManager
    
    
    @State private var title: String = ""
    @State private var notes: String = ""
    @State private var dueDate: Date = Date()
    @State private var location: String = ""
    @State private var category: String = ""
    @State private var isDone: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Task Details")) {
                    TextField("Title",text: $title)
                    TextField("Notes (optional)", text: $notes )
                    
                    DatePicker("Due Date (optional)", selection: $dueDate, displayedComponents: .date)
                }
                
                Section(header: Text("Additional Info")) {
                    TextField("Location (optional)", text: $location)
                    TextField("Category (optional)", text: $category)
                }
            } //form
            .navigationTitle(Text("New Task"))
            .toolbar {
                Button("Cancel") {
                    dismiss()
                }
                
                Button("Save") {
                      dismiss()                 // Your save logic here
                }
                .disabled(title.isEmpty)
            }
        } //NavigationStack
    }
}
