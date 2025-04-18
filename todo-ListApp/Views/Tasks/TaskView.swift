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
        NavigationView {
            ZStack {
                VStack {
                    if tasks.isEmpty {
                        VStack(spacing: 20) {
                            Image(systemName: "tray")
                                .font(.system(size: 48))
                            Text("No Tasks Found")
                            Text("Please click below to add one ")
                        }
                        Spacer()
                    } else {
                        Spacer()
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
                NavigationLink(destination: ProfileView()) {
                    Image(systemName: "person.crop.circle").font(.title2)
                }    //NavigationStack
            }
        }
    }
    
    
    private func taskList(task: Tasks) -> some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                
                
                Text(task.title)
                Spacer()
                if let dueDate = task.dueDate {
                    Text(dueDate.formatted())
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
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
    


