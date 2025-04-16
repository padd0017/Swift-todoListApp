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
    private let firestoreManager: FirestoreManager
    
    init(modelContext: ModelContext, authManager: AuthManager, firestoreManager: FirestoreManager) {
        self.modelContext = modelContext
        self.authManager = authManager
    }
    
    func saveTask(
        title: String,
        notes: String?,
        dueDate: Date?,
        location: String?,
        category: String?
        
    )
}
