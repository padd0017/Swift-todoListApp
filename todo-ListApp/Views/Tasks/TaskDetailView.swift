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
        VStack(spacing: 24) {
            
            VStack(alignment: .leading, spacing: 16) {
            // Due Date
            Text(task.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            if let dueDate = task.dueDate {
                HStack {
                    Image(systemName: "calendar")
                    Text(dueDate.formatted(date: .abbreviated, time: .shortened))
                }
                .font(.subheadline)
                .foregroundColor(.black)
                .padding()
                .cornerRadius(8)
            }
            
            
            VStack(spacing: 4) {
                if let notes = task.notes{
                    DetailItem(icon: "note.text", text: notes)
                }
                
                if let location = task.location{
                    DetailItem(icon: "mappin.and.ellipse", text: location)
                }
                
                if let category = task.category{
                    DetailItem(icon: "tag", text: category)
                }
            }
        }
            .padding()
            .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.gray.opacity(0.5))
                    .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
                    )

                
                
                NavigationLink(destination: UpdateTaskView(task: task)) {
                    Text("Edit Task")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            .navigationTitle("Task Details")
            .navigationBarTitleDisplayMode(.inline)
        }
    }


struct DetailItem: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.gray)
                .frame(width: 30)
            Text(text)
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
    }
}
