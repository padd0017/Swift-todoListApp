//
//  ProfileView.swift
//  todo-ListApp
//
//  Created by Vinaydeep Singh Padda on 2025-04-16.
//


import SwiftUI
import SwiftData

struct UpdateTaskView:  View {
    @ObservedObject var task: Tasks
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var authManager: AuthManager
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationStack{
            VStack {
                TaskForm(
                    title: $task.title,
                    notes: Binding<String>(
                        get: {task.notes ?? ""},
                        set: {task.notes = $0.isEmpty ? nil : $0}
                    ),
                    dueDate: Binding<Date>(
                        get: { task.dueDate ?? Date() },
                        set: { task.dueDate = $0 }
                    ),
                    location: Binding<String>(
                        get: { task.location ?? "" },
                        set: { task.location = $0.isEmpty ? nil : $0 }
                    ),
                    category: Binding<String>(
                        get: { task.category ?? "" },
                        set: { task.category = $0.isEmpty ? nil : $0 }
                    )
                )
                .navigationTitle("Edit Task")
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") { dismiss() }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Save") {
                            Task {
                                await saveChanges()
                                dismiss()
                            }
                        }
                        .disabled(task.title.isEmpty)
                    }
                    
                }
            }
        }
    }
    
    private func saveChanges() async {
        
        do {
            try context.save()
            print("updated in swift data")
        } catch {
            errorMessage = "Unable to save the Changes"
            print("saving Error \(error)")
        }
        
        
        Task {
            do {
                try await FirestoreManager.shared.updateTask(task: task)
                print("firetore updated")
            }catch {
                print("error in updaing in firestore: \(error)")
            }
        }
    }
}
