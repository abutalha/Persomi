//
//  RemoteDBTest.swift
//  PersomiTests
//
//  Created by AbuTalha on 17/07/2022.
//

import XCTest
@testable import Persomi

class PersoViewModel_tests: XCTestCase {

    var mockDataService = MockQuizRepoImpl()
    var quizModel: PersoViewModel!
    
    override func setUpWithError() throws {
        quizModel = PersoViewModel(dataService: mockDataService)
    }

    override func tearDown() async throws {
        quizModel = nil
    }

    func test_PersoViewModel_totalQuestions_EqualToGivenCount() {
        //Given - MockQuizRepoImpl
        //When - Initialized
        //Then
        XCTAssertGreaterThanOrEqual(quizModel.totalQuestions(), 3, "Yes it works")
    }

    func test_PersoViewModel_Question_returnsQuestionAtIndex() {
        let question = quizModel.question(0)
        XCTAssertEqual(question.question, "Adorable A")
    }

    func test_PersoViewModel_moveToNextQuestion_shouldMoveToNextQuestion() {
        //Given
        quizModel.currentIndex = 0
        
        //When
        quizModel.moveToNextQuestion()
        
        //Then
        XCTAssertEqual(quizModel.currentIndex, 1)
    }

    func test_PersoViewModel_isLastQuestion_shouldBeTrue() {
        quizModel.currentIndex = 2
        XCTAssertTrue(quizModel.isLastQuestion())
    }

    
    func test_PersoViewModel_moveToNextQuestion_shouldNotShowResult() {
        quizModel.currentIndex = 2
        XCTAssertTrue(quizModel.isLastQuestion())
        quizModel.moveToNextQuestion()
        
        // Should not show result because no options were selected
        XCTAssertFalse(quizModel.showResult)
    }
    
    func test_PersoViewModel_saveUserResponse_shouldShowResultAsIntrovert() {
        quizModel.currentIndex = 0
        quizModel.saveUserResponse(1)
        quizModel.moveToNextQuestion()
        quizModel.saveUserResponse(1)
        quizModel.moveToNextQuestion()
        quizModel.saveUserResponse(1)
        quizModel.moveToNextQuestion()
        
        XCTAssertTrue(quizModel.showResult)
        XCTAssertEqual(quizModel.getPersonalityTitle(), "You are more of an Introvert")
        XCTAssertEqual(quizModel.getPersonalityTrait(), "About Introvert")
    }
}
