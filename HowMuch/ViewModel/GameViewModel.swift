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
    var currentLevel: Level
    var currentScreen: Screen
    var currentIndex: Int
    var userInput: String
    var questions: [Question]
    
	init(currentLevel: Level = .one, currentScreen: Screen = .levelSelect, currentIndex: Int = 0, userInput: String = "", questions: [Question] = []) {
        self.currentLevel = currentLevel
        self.currentScreen = currentScreen
        self.currentIndex = currentIndex
        self.userInput = userInput
        self.questions = questions
    }
    
    var correctCount: Int {
        questions.filter {
            guard let isCorrect = $0.isCorrect else { return false }
            return isCorrect
        }
        .count
    }
    
    var score: Int {
        guard !questions.isEmpty else {return 0}
        return Int(round((Double(correctCount) / Double(questions.count) * 100)))
    }
    
    var resultMessage: String {
        """
        \(score) 점 획득!
        \(["⭐️", "⭐️", "⭐️", "⭐️", "⭐️"][0..<starCount].joined())
        \(questions.count) 문제 중
        \(correctCount) 문제를 맞췄습니다
        """
    }
    
    var starCount: Int {
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
            questions[currentIndex].isCorrect = (rightAnswer == userAnswer)
        } else {
            questions[currentIndex].isCorrect = false
        }
    }
    
    func nextQuestion() {
        defer {
            userInput = ""
        }
        switch currentIndex {
        case 0...13:
            addQuestion()
            currentIndex += 1
        case 14:
            currentScreen = Screen.result
			currentIndex = 0
        default:
            print("Error")
        }
		print(questions.count)
    }
    
    func addQuestion() {
        questions.append(Question(level: currentLevel))
    }
    
    func startGame(level: Level) {
        currentLevel = level
        questions = [Question(level: level)]
        currentIndex = 0
        userInput = ""
        currentScreen = .game
    }
	
}
