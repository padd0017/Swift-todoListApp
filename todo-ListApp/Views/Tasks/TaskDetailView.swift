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
            ZStack {
                VStack{
                    Text(task.title)
                        .font(.headline)
                    if let dueDate = task.dueDate{
                        Text(dueDate, style: .date)
                    }
                }
                
                VStack {
                    if let notes = task.notes{
                        Text(notes)
                    }
                    
                    if let location = task.location{
                        Text(location)
                    }
                }
                
                
            }
        }
    }
    }

