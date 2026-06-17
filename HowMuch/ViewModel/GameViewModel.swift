//
//  GameViewModel.swift
//  HowMuch
//
//  Created by yoonie on 6/17/26.
//

import Foundation
import Observation


@MainActor
@Observable
final class GameViewModel {
    var currentScreen: Screen
    var currentIndex: Int
    var userInput: String
    var questions: [Question]
    
    init(currentScreen: Screen = .levelSelect, currentIndex: Int = 0, userInput: String = "", questions: [Question] = []) {
        self.currentScreen = currentScreen
        self.currentIndex = currentIndex
        self.userInput = userInput
        self.questions = questions
    }
    
    var correctCount: Int {
        questions.filter {
            guard let isCorrect = $0.boolsEye else { return false }
            return isCorrect
        }
        .count
    }
    
    var resultMessage: String {
        """
        \(correctCount / questions.count) 점 획득!
        \(["⭐️", "⭐️", "⭐️", "⭐️", "⭐️"][0..<starCount].joined())
        \(questions.count) 문제 중
        \(correctCount) 문제를 맞췄습니다
        """
    }
    
    var starCount: Int {
        let score = correctCount / questions.count
        switch score {
        case 1...25: return 1
        case 26...50: return 2
        case 51...75: return 3
        case 76...99: return 4
        case 100: return 5
        default: return 0
        }
    }
    
    func checkAnswer() {
        let rightAnswer = questions[currentIndex].answer()
        if let userAnswer = Int(userInput) {
            questions[currentIndex].boolsEye = (rightAnswer == userAnswer)
        } else {
            questions[currentIndex].boolsEye = false
        }
    }
    func nextQuestion() {}
    func generateQuestions(level: Level) {}
}
