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
            VStack(spacing: 10){
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(Color(.systemGray6))
                    .autocapitalization(.none)
                    .cornerRadius(10)
                
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .autocapitalization(.none)
                    .cornerRadius(10)
                
                
                    Button("Login"){
                        Task {
                            do {
                                _ = try await authManager.login(email: email, password: password)
                                errorMessage = nil
                            } catch {
                                errorMessage = "Please check your email and password."
                            }
                        }
                    }
                    .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(email.isEmpty || password.isEmpty ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    
                    Button("Create Account") {
                        Task {
                            ShowSignUpView = true
                        }
                    }
                    .sheet(isPresented: $ShowSignUpView ){
                        CreateAccountView()
                    }
                    .foregroundColor(.blue)
                    
                    
                   
               
                
                
            }//VStack
            .navigationTitle("Login")
            .padding()
        }//NavigationStack
        
    }
}
