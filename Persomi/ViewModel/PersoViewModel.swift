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

    // mapping the score for each question
    private var result: [Int:Int] = [:]
    private var totalScore = 0
    private var bag = Set<AnyCancellable>()
    private var quizRepo = QuizRepo()

    @Published var quiz = Quiz()
    @Published var currentIndex: Int = 0
    @Published var showResult = false
    
    init() {
        // sync any changes from Repository to this viewmodel
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
        result[currentIndex] = choiceIndex
    }
    
    func moveToNextQuestion() {
        if isLastQuestion() {
            totalScore = result.compactMap { quiz.questions[currentIndex].scores[$0.value] }.reduce(0, +)
            showResult.toggle()
        } else {
            currentIndex += 1
        }
    }

    func moveToPreviousQuestion() {
        if !isFirstQuestion() {
            currentIndex -= 1
        }
    }
    
    func isSelected(_ index: Int) -> Bool {
        result[currentIndex] == index
    }
    
    func isFirstQuestion() -> Bool {
        currentIndex == 0
    }

    func isLastQuestion() -> Bool {
        (currentIndex + 1) == quiz.questions.count
    }
    
    func getPersonalityTitle() -> String {
        totalScore < 5 ? "Introvert" : "Extrovert"
    }
    
    func getPersonalityTrait() -> String {
        totalScore < 5 ? quiz.aboutIntro : quiz.aboutExtro
    }
    
    func reset() {
        currentIndex = 0
        totalScore = 0
        result = [:]
        showResult = false
    }
}
