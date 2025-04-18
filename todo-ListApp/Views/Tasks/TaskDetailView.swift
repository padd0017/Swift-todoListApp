//
//  TaskDetailView.swift
//  todo-ListApp
//
//  Created by Vinaydeep Singh Padda on 2025-04-17.
//

import Foundation

import SwiftUI


struct TaskDetailView:  View {
    let task: Tasks
    @EnvironmentObject var authManager: AuthManager
    var body: some View {
        NavigationStack {
            VStack {
                VStack{
                    if let dueDate = task.dueDate{
                        Text(dueDate, style: .date)
                    }
                }
                
                VStack(spacing: 20) {
                    if let notes = task.notes{
                        Text(notes)
                    }
                    
                    if let location = task.location{
                        Text(location)
                    }
                    
                    if let Category = task.category{
                        Text(Category)
                    }
                }
                
                
                NavigationLink(destination: UpdateTaskView(task: task)) {
                    Text("Update Task")
                }
                    
                
                
            }
            .navigationTitle(task.title)
        }
    }
    }

