//
//  CreateAccountView.swift
//  todo-ListApp
//
//  Created by Vinaydeep Singh Padda on 2025-04-16.
//

import Foundation
import SwiftUI

struct CreateAccountView:  View {
    @EnvironmentObject var authManager: AuthManager
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var name: String = ""
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationStack{
            
            VStack(spacing: 20){
                Text("Create Account")
                    .font(.headline)
                
                TextField("Name", text: $name)
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .padding()
                
                SecureField("Password", text: $password)
                    .padding()
                
                if let errorMessage = errorMessage {
                        Text(errorMessage)
                        }
                
                Button("Create Account") {
                    Task {
                        await createAccount()
                    }
                }
            }//Vstack
        }//navigationStack
    }
    
    private func createAccount() async {
        errorMessage = nil
        
        
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill in all fields."
            return
        }
        
        
        do {
            let success = try await authManager.createAccount(email: email, password: password, name: name)
            
            if success, let user = authManager.user {
                let profile = Profile(
                                   userId: user.uid,
                                   email: email,
                                   name: name
                               )
                
                context.insert(profile)
                try? context.save()
                dismiss()
            }
        } catch{
            errorMessage = error.localizedDescription
        }
    }
}


