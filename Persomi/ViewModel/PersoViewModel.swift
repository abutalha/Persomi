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
    private var quizRepo = QuizRepo()
    @Published var quiz = Quiz()
    @Published var userResponse: [Int] = []
    //@Published var currentIndex: Int = 0
    private var bag = Set<AnyCancellable>()

    init() {
        quizRepo.$quiz
            .sink { quiz in
                self.quiz = quiz
            }
            .store(in: &bag)
    }
    
    func allQuestions() -> [Question] {
        quiz.questions
    }
    
    func question(_ index: Int) -> Question {
        if quiz.questions.count > 0 {
            return quiz.questions[index]
        }
        return Question()
    }
    
    func answers(_ index: Int) -> [String] {
        quiz.questions[index].answers
    }
    
    func submitAnswer(_ choiceIndex: Int) {
        
    }
    
    func totalQuestions() -> Int {
        quiz.questions.count
    }
    
    func saveUserResponse(_ questionIndex: Int, _ choiceIndex: Int) {
        userResponse.append(quiz.questions[questionIndex].scores[choiceIndex])
    }
    
    func isFirstQuestion(_ index: Int) -> Bool {
        print (totalQuestions())
        return (index + 1) < totalQuestions()
    }
    
    func getResult() -> (String, String) {
        let totalScore = userResponse.reduce(0, +)
         
        if (totalScore < 5) {
            return ("Introvert", quiz.aboutIntro)
        } else {
            return ("Extrovert", quiz.aboutExtro)
        }
    }
}
