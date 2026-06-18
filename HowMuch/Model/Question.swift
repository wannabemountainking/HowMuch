//
//  Calculations.swift
//  HowMuch
//
//  Created by YoonieMac on 6/17/26.
//

import Foundation


enum Level: CaseIterable {
    case one, two, three, four
    
    func generateNumbers() -> [Int] {
        switch self {
        case .one:
            return [Int.random(in: 0...9), Int.random(in: 0...9)].sorted(by: { $0 > $1 })
        case .two:
            return [Int.random(in: 10...99), Int.random(in: 0...9)]
        case .three:
            return [Int.random(in: 100...999), Int.random(in: 0...9)]
        case .four:
            return [Int.random(in: 10...99), Int.random(in: 10...99)].sorted(by: { $0 > $1 })
        }
    }
}

enum Operation: CaseIterable {
    case add, subtract, multiply
    
    func calculate(lhs: Int, rhs: Int) -> Int {
        switch self {
        case .add:
            return lhs + rhs
        case .subtract:
            guard lhs >= rhs else {
                print("앞의 수가 뒤의 수보다 작습니다")
                return -1
            }
            return lhs - rhs
        case .multiply:
            return lhs * rhs
        }
    }
}

struct Question {
	var operation: Operation
	var lhs: Int
	var rhs: Int
	var isCorrect: Bool? = nil
    
	
	init(level: Level) {
        let numbers: [Int] = level.generateNumbers()
        self.lhs = numbers[0]
        self.rhs = numbers[1]
        let allTheOperations = Operation.allCases
        self.operation = allTheOperations[Int.random(in: 0..<allTheOperations.count)]
	}
	
	func answer() -> Int {
        operation.calculate(lhs: lhs, rhs: rhs)

	}
}
