//
//  Helpers.swift
//  HowMuch
//
//  Created by yoonie on 6/17/26.
//

import Foundation
import SwiftUI

enum Screen: Equatable {
    case levelSelect, game, result
}

enum Key: Hashable {
    case digit(Int)
    case delete
    case deleteAll
    case confirm
	case none
	
	var text: String {
		switch self {
		case .digit(let number): return "\(number)"
		case .delete: return "지우기"
		case .deleteAll: return "모두 지우기"
		case .confirm: return "확인"
		case .none: return ""
		}
	}
	
	var keyBackground: String {
		switch self {
		case .digit: return HexColors.digitKey
		case .delete: return HexColors.deleteKey
		case .deleteAll: return HexColors.deleteAllKey
		case .confirm: return HexColors.confirmKey
		case .none: return HexColors.digitKeyBorder
		}
	}
	
	var keyTextColor: String {
		switch self {
		case .digit: return HexColors.digitKeyText
		case .delete: return HexColors.deleteKeyText
		case .deleteAll: return HexColors.deleteAllKeyText
		case .confirm: return HexColors.confirmKeyText
		case .none: return HexColors.digitKeyBorder
		}
	}
	
	var gridCellColums: Int {
		switch self {
		case .digit(let num):
			return (num == 0) ? 2 : 1
		case .delete, .deleteAll:
			return 2
		case .confirm:
			return 4
		case .none:
			return 1
		}
	}
}

enum ComponentRatio {
	// 헤더
	static let headerHeight: Double = 0.08
	// 문제 표시 영역
	static let questionAreaHeight: Double = 0.35
	// 키패드 영역
	static let keypadAreaHeight: Double = 0.50
	// 키패드 버튼 높이
	static let keyHeight: Double = 5
	// 문제 폰트
	static let questionFontSize: Double = 0.08
	// 버튼 폰트
	static let keyFontSize: Double = 0.06

	// 결과 화면
	static let resultCharacterHeight: Double = 0.55
	static let resultCardWidth: Double = 0.50
	static let resultCardHeight: Double = 0.32
	static let resultScoreFontSize: Double = 0.16
	static let resultSubScoreFontSize: Double = 0.05
	static let resultButtonWidth: Double = 0.50
	static let resultButtonHeight: Double = 0.08
	static let resultCardCornerRadius: Double = 0.03
	static let resultButtonCornerRadius: Double = 0.02
}

enum HexColors {
	// 메인 배경
	static let mainBackground: String = "#FF6B6B"
	// 단계 이름
	static let levelSelectGrade: String = "#A32D2D"
	static let levelSelectDescription: String = "#888888"

	// 게임
	static let gameBackground: String = "#F7F7F2"
	static let gameHeader: String = "#FF6B6B"
	static let questionBackground: String = "#FFF8F8"
	static let questionText: String = "#0B2D39"
	static let operatorText: String = "#FF6B6B"
	static let answerBox: String = "#FF6B6B"

	// 키패드
	static let digitKey: String = "#FFFFFF"
	static let digitKeyText: String = "#0B2D39"
	static let digitKeyBorder: String = "#E8E0E0"
	static let deleteKey: String = "#FFBF69"
	static let deleteKeyText: String = "#633806"
	static let deleteAllKey: String = "#FFE8CC"
	static let deleteAllKeyText: String = "#854F0B"
	static let confirmKey: String = "#1FB6AA"
	static let confirmKeyText: String = "#FFFFFF"

	// 결과 화면
	static let resultBackground: String = "#FF6B6B"
	static let resultCard: String = "#FFFFFF"
	static let resultScoreText: String = "#FF6B6B"
	static let resultDivider: String = "#FFE0E0"
	static let resultSubText: String = "#888888"
	static let resultSlash: String = "#CCCCCC"
	static let resultRetryButton: String = "#1FB6AA"
	static let resultRetryText: String = "#FFFFFF"
	static let resultQuitButton: String = "#FFE8CC"
	static let resultQuitText: String = "#854F0B"
}

extension Color {
    init(hex: String) {
        let intHex = Int(hex.trimmingCharacters(in: CharacterSet(charactersIn: "#")), radix: 16) ?? 0
        let maxValue: Double =  255
        let r: Double = Double(intHex >> 16 & 0xFF) / maxValue
        let g: Double = Double(intHex >> 8 & 0xFF) / maxValue
        let b: Double = Double(intHex & 0xFF) / maxValue
        self.init(red: r, green: g, blue: b)
    }
}

