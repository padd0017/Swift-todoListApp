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
            
            VStack(spacing: 24){
                Text("Create Account")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.black)
                
                TextField("Name", text: $name)
                    .padding()
                    .background(Color(.systemGray6))
                    .autocapitalization(.none)
                    .cornerRadius(10)
                    .foregroundColor(Color(.black))
                
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(Color(.systemGray6))
                    .autocapitalization(.none)
                    .cornerRadius(10)
                    .foregroundColor(Color(.black))
                
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .autocapitalization(.none)
                    .cornerRadius(10)
                    .foregroundColor(Color(.black))
                
                
                if let errorMessage = errorMessage {
                        Text(errorMessage)
                        }
                
                Button("Create Account") {
                    Task {
                        await createAccount()
                    }
                }
                .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(email.isEmpty || password.isEmpty ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()//Vstack
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


