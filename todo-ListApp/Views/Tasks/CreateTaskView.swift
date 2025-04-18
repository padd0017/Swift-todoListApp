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
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    
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
                    
                    Task {
                        
                        await saveTask()
                        print("Task created")
                    }                // Your save logic here
                }
                .disabled(title.isEmpty)
            }
        } //NavigationStack
    }
    
    private func saveTask() async {
        do {
            let taskManager = DisplayTaskManager(modelContext: context, authManager: authManager)
            
            try await taskManager.createTask(
                title: title,
                notes: notes.isEmpty ? nil : notes,
                dueDate: dueDate,
                location: location.isEmpty ? nil : location,
                category: category.isEmpty ? nil : category)
            
            dismiss()
        } catch {
            errorMessage = "Failed to save task: \(error.localizedDescription)"
            showError = true
        }
    }
}
