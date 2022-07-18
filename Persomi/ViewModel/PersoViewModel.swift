//
//  PersoViewModel.swift
//  Persomi
//
//  Created by AbuTalha on 13/07/2022.
//

import Foundation
import UIKit

class PersoViewModel : ObservableObject {

    // mapping the score for each question
    private var result: [Int:Int] = [:]
    private var totalScore = 0
    private var quizDataService: QuizDataProtocol!
    
    @Published var quiz = Quiz()
    @Published var currentIndex: Int = 0
    @Published var showResult = false
    @Published var viewId = 0
    
    init(dataService: QuizDataProtocol) {
        self.quizDataService = dataService
        quizDataService.fetchData { [weak self] result in
            self!.quiz = result
//            print ("Count: \(self?.quiz.questions.count)")
        }
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
    
    func totalQuestions() -> Int {
        quiz.questions.count
    }
    
    func saveUserResponse(_ choiceIndex: Int) {
        result[currentIndex] = choiceIndex
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    func moveToNextQuestion() {
        if isLastQuestion() {
            
            // find any question skipped question and scroll to it before allowing them to view results
            for index in 0..<quiz.questions.count {
                if !result.keys.contains(index) {
                    currentIndex = index
                    return
                }
            }
            
            // calculate total score based on their choices
            totalScore = result.compactMap { quiz.questions[currentIndex].scores[$0.value]
            }.reduce(0, +)
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
       "You are more of an \(totalScore < (5 * quiz.questions.count) ? "Introvert" : "Extrovert")"
    }
    
    func getPersonalityTrait() -> String {
        totalScore < (5 * quiz.questions.count) ? quiz.aboutIntro : quiz.aboutExtro
    }
    
    func reset() {
        currentIndex = 0
        totalScore = 0
        result.removeAll()
        showResult = false
        
        // small hack to force QuestionView to redraw so the state variables will be reset when the quiz start over.
        viewId = viewId >= Int.max ? 0 : viewId + 1
    }
}
