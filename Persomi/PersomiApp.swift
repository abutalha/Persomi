//
//  PersomiApp.swift
//  Persomi
//
//  Created by AbuTalha on 13/07/2022.
//

import SwiftUI
import FirebaseCore

@main
struct PersomiApp: App {
    private var quizDataService: QuizDataService
    
    init() {
        FirebaseApp.configure()
        quizDataService = QuizDataService()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeScreen(quizDataService: quizDataService)
        }
    }
}
