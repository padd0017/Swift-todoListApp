//
//  LoginView.swift
//  todo-ListApp
//
//  Created by Vinaydeep Singh Padda on 2025-04-15.
//

import Foundation
import SwiftUI


struct LoginView:  View {
    @EnvironmentObject var authManager: AuthManager
    @State var email: String = ""
    @State var password: String = ""
    @State private var ShowSignUpView: Bool = false
    @State private var errorMessage: String?
    
    
    var body: some View {
        NavigationStack{
            VStack{
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                SecureField("Password", text: $password)
                HStack {
                    
                    
                    Button("Login") {
                        Task {
                            do {
                                _ = try await authManager.login(email: email, password: password)
                                errorMessage = nil
                            } catch {
                                errorMessage = "Please check your email and password."
                            }
                        }
                    }
                    .padding()
                    
                    Button("Create Account") {
                        Task {
                            ShowSignUpView = true
                        }
                    }
                    .sheet(isPresented: $ShowSignUpView ){
                        CreateAccountView()
                    }
                    
                   
                } //HStack
                
                
            }//VStack
            .navigationTitle("Login")
        }//NavigationStack
        
    }
}
