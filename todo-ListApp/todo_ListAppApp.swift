//
//  todo_ListAppApp.swift
//  todo-ListApp
//
//  Created by Vinaydeep Singh Padda on 2025-04-15.
//

import SwiftUI
import FirebaseCore
import SwiftData


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct todo_ListAppApp: App {
    @StateObject private var authManager = AuthManager.shared
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate


  var body: some Scene {
    WindowGroup {
      NavigationView {
        ContentView()
      }
    }
    .environmentObject(authManager)
    .modelContainer(for: [Tasks.self, Profile.self])
      
  }
}
