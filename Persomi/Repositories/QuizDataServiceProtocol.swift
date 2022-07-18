//
//  QuizRepo.swift
//  Persomi
//
//  Created by AbuTalha on 14/07/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

typealias ResponseHandler = (Quiz)->Void

protocol QuizDataProtocol {
    func fetchData(completion: @escaping ResponseHandler)
}

final class QuizDataService : QuizDataProtocol {
    private var db = Firestore.firestore()

    func fetchData(completion: @escaping ResponseHandler) {
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
                    completion(result)
//                    self.quiz = result
                    print ("Repo: \(result.questions.count)")
                }
            } catch {
                print ("Error: \(error.localizedDescription)")
            }
        }
    }
}
