//
//  TaskView.swift
//  todo-ListApp
//
//  Created by Vinaydeep Singh Padda on 2025-04-15.
//

import SwiftUI
import SwiftData


struct TaskView:  View {
    @Query var tasks: [Tasks]
    @EnvironmentObject var authManager: AuthManager
    @Environment(\.modelContext) var context
    private let firestoreManager = FirestoreManager.shared
    @State private var taskToDelete: Tasks?
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    if tasks.isEmpty {
                        Spacer()
                        VStack(alignment: .center, spacing: 12) {
                            Image(systemName: "tray")
                                .font(.system(size: 48))
                                .foregroundColor(.gray)
                            Text("No Tasks Found")
                                .font(.headline)
                                .foregroundColor(.gray)
                            Text("Please click below to add one ")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    } else {
                        List {
                            ForEach(tasks) {task in
                                NavigationLink(destination: TaskDetailView(task: task)){
                                    taskList(task: task)
                                }
                                .listRowBackground(
                                    task.isDone ? Color.green.opacity(0.4) : Color.white
                                )
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination: CreateTaskView()) {
                            Image(systemName: "plus")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                            
                        }
                        .padding(.trailing, 16)
                        .padding(.bottom, 16)
                    }
                }//Vstack
            }
            .navigationTitle("Google Tasks")
            .toolbar{
                NavigationLink(destination: ProfileView(tasks: tasks)) {
                    Image(systemName: "person.crop.circle").font(.title2)
                }    //NavigationStack
            }
        }
    }
    
    
    private func taskList(task: Tasks) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(task.title)
                    .font(.headline)
                    .strikethrough(task.isDone, color: .gray)
                Spacer()
                if let dueDate = task.dueDate {
                    Text(dueDate.formatted())
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding(10)
            .swipeActions(edge: .leading) {
                Button("Mark as Completed"){
                    task.isDone.toggle()
                }
                .tint(Color.green)
            }
            .swipeActions(edge: .trailing){
                Button("Delete", role: .destructive) {
                    context.delete(task)
                    do {
                        try context.save()
                        print("deleted form swift data now going to delete from firestore")
                        Task {
                            do {
                                try await FirestoreManager.shared.deleteTask(task: task)
                                
                            } catch {
                                print("firestore delete error: \(error)")
                            }
                        }
                        
                    } catch {
                        print("SwiftData delete Error: \(error)")
                    }
                }
            }
        }
    }
    
}
    


