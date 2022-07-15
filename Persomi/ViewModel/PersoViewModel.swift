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
    @Published var currentIndex: Int = 0
    private var bag = Set<AnyCancellable>()

    // mapping the score for each question
    private var result: [Int:Int] = [:]

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
    
    func saveUserResponse(_ choiceIndex: Int) {
        result[currentIndex] = quiz.questions[currentIndex].scores[choiceIndex]
        moveToNextQuestion()
    }
    
    func moveToNextQuestion() {
        if isLastQuestion() {
           // show results
        } else {
            currentIndex += 1
        }
    }

    func moveToPreviousQuestion() {
        if !isFirstQuestion() {
            currentIndex -= 1
        }
    }
    
    func isFirstQuestion() -> Bool {
        currentIndex == 0
    }

    func isLastQuestion() -> Bool {
        (currentIndex + 1) == quiz.questions.count
    }
    
    func getResult() -> (String, String) {
        let totalScore = result.compactMap { $0.value }.reduce(0, +)
            
        if (totalScore < 5) {
            return ("Introvert", quiz.aboutIntro)
        } else {
            return ("Extrovert", quiz.aboutExtro)
        }
    }
}
