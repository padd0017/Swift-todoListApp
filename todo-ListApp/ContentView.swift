//
//  ContentView.swift
//  todo-ListApp
//
//  Created by Vinaydeep Singh Padda on 2025-04-15.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager
//    @Environment(\.modelContext) private var context
//    
    
    var body: some View{
        Group {
            if AuthManager.shared.isSignedIn {
                TaskView()
            } else {
                LoginView()
            }
        }
    }
    
}

#Preview {
    ContentView()
        .environmentObject(AuthManager.shared)
        .modelContainer(for: [Tasks.self, Profile.self])
}
