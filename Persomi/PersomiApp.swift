//
//  PersomiApp.swift
//  Persomi
//
//  Created by AbuTalha on 13/07/2022.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}


@main
struct PersomiApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var persoVM = PersoViewModel()
    
    var body: some Scene {
        WindowGroup {
//            IntroScreen()
            HomeScreen()
                .environmentObject(persoVM)
        }
    }
}
