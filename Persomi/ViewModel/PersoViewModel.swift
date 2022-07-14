//
//  PersoViewModel.swift
//  Persomi
//
//  Created by AbuTalha on 13/07/2022.
//

import Foundation
import Combine

@MainActor
class PersoViewModel : ObservableObject {
    @Published var quiz: Quiz?
    @Published var userResponse: [Int] = []
    private var quizRepo = QuizRepo()
    private var bag = Set<AnyCancellable>()

    init() {
        quizRepo.$quiz
            .sink { quiz in
                self.quiz = quiz
            }
            .store(in: &bag)
    }
    
    func question(_ index: Int) -> String {
        (quiz?.questions[index].question) ?? "..."
    }
    
    func answers(_ index: Int) -> [String] {
        (quiz?.questions[index].answers) ?? []
    }
    
    func saveUserResponse(_ questionIndex: Int, _ choiceIndex: Int) {
        userResponse.append((quiz?.questions[questionIndex].scores[choiceIndex]) ?? 0)
    }
    
    func getResult() -> (String, String) {
        let totalScore = userResponse.reduce(0, +)
         
        if (totalScore < 5) {
            return ("Introvert", quiz?.aboutIntro ?? "...")
        } else {
            return ("Extrovert", quiz?.aboutExtro ?? "...")
        }
    }
}
