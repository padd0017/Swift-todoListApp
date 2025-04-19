//
//  AuthManager.swift
//  todo-ListApp
//
//  Created by Vinaydeep Singh Padda on 2025-04-15.
//
import Foundation
import FirebaseAuth


@MainActor
class AuthManager: ObservableObject {
        static let shared = AuthManager()
        @Published var user: User?
        @Published var isSignedIn: Bool = false
        @Published var error: Bool = false
    
    init(user: User? = nil, isSignedIn: Bool = false) {
          self.user = user
          self.isSignedIn = isSignedIn
          _ = Auth.auth().addStateDidChangeListener { _, user in
              self.user = user
              self.isSignedIn = user != nil
          }
      }
    
    
    func login(email: String, password: String) async throws-> Bool {
            try await Auth.auth().signIn(withEmail: email, password: password)
            return true
        
     
    }
    
    
    func createAccount(email: String, password: String, name: String) async throws  -> Bool{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)


        
        self.user = result.user
        self.isSignedIn = true
        return true
    }
    
    
    func logout() throws  -> Bool {
        try Auth.auth().signOut()
        self.user = nil
               self.isSignedIn = false
               return true
    }
}
