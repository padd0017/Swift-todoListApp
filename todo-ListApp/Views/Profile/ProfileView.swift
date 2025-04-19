//
//  ProfileView.swift
//  todo-ListApp
//
//  Created by Vinaydeep Singh Padda on 2025-04-16.
//

import Foundation

import SwiftUI


struct ProfileView:  View {
    var tasks: [Tasks]
    @EnvironmentObject var authManager: AuthManager
    @Environment(\.modelContext) private var context
    var body: some View {
        VStack{
            if let user = authManager.user{
                
                Text(user.email ?? "")
            }
            
            Button("Logout"){
                Task {
                    for task in tasks{
                        context.delete(task)
                    }
                    
//                    context.delete([tasks])
                  _ =  try authManager.logout()
                
                    
                }
            }
        }
    }
}
