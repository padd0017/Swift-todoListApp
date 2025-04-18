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
            Section {
                TextField("Title", text: $title)
                    .font(.headline)
                    .padding(.vertical, 12)
                
                TextField("Notes", text: $notes)
                    .padding(.vertical, 12)
                
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                    .padding(.vertical, 8)
                    .labelsHidden()
            } header: {
                SectionHeader(text: "Task Details")
            }

            Section {
                TextField("Location", text: $location)
                    .padding(.vertical, 12)
                
                TextField("Category", text: $category)
                    .padding(.vertical, 12)
            } header: {
                SectionHeader(text: "Additional Info")
            }
        }
        .listStyle(.grouped)
        .environment(\.horizontalSizeClass, .regular)
    }
}

private struct SectionHeader: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.subheadline)
            .foregroundColor(.gray)
            .padding(.bottom, 8)
    }
}
