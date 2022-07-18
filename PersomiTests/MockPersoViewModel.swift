//
//  MockPersoViewModel.swift
//  PersomiTests
//
//  Created by AbuTalha on 17/07/2022.
//

import Foundation
@testable import Persomi

class MockQuizRepoImpl : QuizDataProtocol {
    func fetchData(completion: (Quiz)->Void) {
        let quiz = Quiz(id: "1",
                         questions: [
                            Question(id: "0",
                                     question: "Adorable A",
                                     answers: ["a", "b", "c", "d"],
                                     scores: [1,2,3,4]),
                            Question(id: "1",
                                     question: "Breaking B",
                                     answers: ["a", "b", "c", "d"],
                                     scores: [1,2,3,4]),
                            Question(id: "2",
                                     question: "Catchy C",
                                     answers: ["a", "b", "c", "d"],
                                     scores: [1,2,3,4])],
                         aboutIntro: "About Introvert",
                         aboutExtro: "About Extrovert")
        
        completion(quiz)
    }
}
