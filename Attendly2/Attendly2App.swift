//
//  Attendly2App.swift
//  Attendly2
//
//  Created by Rania Alageel on 10/02/1444 AH.
//

import SwiftUI
import FirebaseCore
import Firebase
import CoreNFC




class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
   FirebaseApp.configure()

    return true
  }
}
@main
struct Attendly2App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
          splashScreenView()
            //ContentView()
            //tabBar()
        }
    }
}
