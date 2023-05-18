//
//  EasyMealApp.swift
//  EasyMeal
//
//  Created by Alex Strugacz on 2/1/23.
//


import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
  
    return true
  }
}

@main
struct EasyMealApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    @StateObject private var firebaseManager = FirebaseManager()
    
    var body: some Scene {
        WindowGroup {
            MainPage()
                .environmentObject(firebaseManager)
        }
    }
}
