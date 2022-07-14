//
//  Question.swift
//  Persomi
//
//  Created by AbuTalha on 13/07/2022.
//

import Foundation
import FirebaseFirestoreSwift

struct Question : Codable {
    var id: String? = UUID().uuidString
    var question: String = ""
    var answers: [String] = []
    var scores: [Int] = []
}

struct Quiz : Codable {
    @DocumentID var id: String?
    var questions: [Question]
    var aboutIntro: String
    var aboutExtro: String
}
