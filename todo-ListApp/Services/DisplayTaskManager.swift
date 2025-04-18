//
//  DisplayTaskManager.swift
//  todo-ListApp
//
//  Created by Vinaydeep Singh Padda on 2025-04-16.
//

import Foundation
import SwiftData
import FirebaseFirestore


class DisplayTaskManager {
    private let modelContext: ModelContext
    private let authManager: AuthManager
    private let firestoreManager = FirestoreManager.shared
    
    init(modelContext: ModelContext, authManager: AuthManager) {
        self.modelContext = modelContext
        self.authManager = authManager
    }
    
    func createTask(title: String, notes: String?,dueDate: Date?,location: String?,category: String?) async throws {

        let newTask = Tasks(title: title, notes: notes, dueDate: dueDate, location: location, category: category, isDone: false)
        
        try saveToSwift(task: newTask)
        
        try? await saveToFireStore(task: newTask)
    }
    
    
    private func saveToSwift(task: Tasks)  throws {
        modelContext.insert(task)
        print("Saved to swift now going to save to firestore")
        try modelContext.save()
    }
    
    private func saveToFireStore(task: Tasks) async throws {
        
        guard await authManager.user != nil else {
            return
        }
        
        do {
          _ =  try await firestoreManager.saveTask(task: task)
            if task.firebaseId == nil {
                try saveToSwift(task: task)
            }
        } catch {
            print("firestore save failed: \(error.localizedDescription)")
        }
        
        
        
    }
}
