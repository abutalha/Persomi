//
//  QuizRepo.swift
//  Persomi
//
//  Created by AbuTalha on 14/07/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class QuizRepo : ObservableObject {
    private var db = Firestore.firestore()
    @Published var quiz: Quiz?
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        db.collection("quiz").addSnapshotListener { snapshot, error in
            if let error = error {
                print("Error reading data from server: \(error.localizedDescription)")
            }
            
            guard let docs = snapshot?.documents else {
                print("No Question found in database")
                return
            }
            
            do {
                if let result = try docs.first?.data(as: Quiz.self) {
                    self.quiz = result
                }
            } catch {
                print ("Error: \(error.localizedDescription)")
            }
        }
    }
}
