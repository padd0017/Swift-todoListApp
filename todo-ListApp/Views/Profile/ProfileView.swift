//
//  ProfileView.swift
//  todo-ListApp
//
//  Created by Vinaydeep Singh Padda on 2025-04-16.
//

import Foundation

import SwiftUI


struct ProfileView:  View {
    var tasks: Tasks
    @EnvironmentObject var authManager: AuthManager
    @Environment(\.modelContext) private var context
    var body: some View {
        HStack{
            Button("Logout"){
                Task {
                    context.delete(tasks)
                  _ =  try authManager.logout()
                
                    
                }
            }
        }
    }
}
