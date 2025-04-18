//
//  ProfileView.swift
//  todo-ListApp
//
//  Created by Vinaydeep Singh Padda on 2025-04-16.
//

import Foundation

import SwiftUI


struct ProfileView:  View {
    @EnvironmentObject var authManager: AuthManager
    var body: some View {
        HStack{
            Button("Logout"){
                Task {
                    try  authManager.logout()
                }
            }
        }
    }
}
