//
//  Calculations.swift
//  HowMuch
//
//  Created by YoonieMac on 6/17/26.
//

import Foundation


enum Screen: Equatable {
	case levelSelect, game, result
}

enum Operation: CaseIterable {
	case add, subtract, multiply, none
	
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
		default:
			print("none")
		}
	}
}

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

struct Question {
	var operation: Operation
	var lhs: Int
	var rhs: Int
	var boolsEye: Bool? = nil
	
	init(level: Level) {
		self.lhs = level.generateNumbers().first ?? -9999
		self.rhs = level.generateNumbers().last ?? -9999
		var ops = Array(Operation.allCases)
		ops.removeLast()
		self.operation = ops.randomElement() ?? .none
	}
	
	func answer() -> Int {
		switch operation {
		case .add:
			return lhs + rhs
		case .subtract:
			return lhs - rhs
		case .multiply:
			return lhs * rhs
		case .none:
			return -9999
		}
	}
}
