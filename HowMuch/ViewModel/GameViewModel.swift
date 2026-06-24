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
	
	var isRetryMode: Bool = false
	var retryIndex: Int = 0
    
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
	
	var resultImageName: String {
		switch score {
		case 100: return "perfectScore"
		case 51...99: return "excellentScore"
		default: return "demandingScore"
		}
	}
	
	var retryQuestions: [Question] {
		questions.filter { $0.isCorrect == false }
	}
    
    func checkAnswer() {
        let rightAnswer = questions[currentIndex].answer()
        if let userAnswer = Int(userInput) {
			if !isRetryMode {
				questions[currentIndex].isCorrect = (rightAnswer == userAnswer)
			} else {
				if let idx = questions.firstIndex(where: { $0.id == retryQuestions[retryIndex].id }) {
					questions[idx].isCorrect = true
				}
			}
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
	
	func retry() {
		isRetryMode = true
		questions.map {
			$0.isCorrect = $0.isCorrect ? true : nil
		}
		retryIndex = 0
		currentScreen = .game
	}
	
	func quit() {
		currentIndex = 0
		questions = []
		userInput = ""
		isRetryMode = false
		retryIndex = 0
		currentScreen = .levelSelect
	}
}
