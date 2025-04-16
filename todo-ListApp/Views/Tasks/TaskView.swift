//
//  TaskView.swift
//  todo-ListApp
//
//  Created by Vinaydeep Singh Padda on 2025-04-15.
//

import SwiftUI


struct TaskView:  View {
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Text("Task View")
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
                }
                
            }
            .navigationTitle("Google Tasks")
            .toolbar{
                NavigationLink(destination: ProfileView()) {
                    Image(systemName: "person.crop.circle").font(.title2)
                }
            }
        }    //NavigationStack
    }
}
