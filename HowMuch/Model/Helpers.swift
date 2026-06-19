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

enum HexColors {
    // 메인 배경 (빨간색)
    static let levelSelectBackground: String = "#FF6B6B"
    // 단계 이름
    static let levelSelectGrade: String = "#A32D2D"
    // 2 단계 이름
    static let levelSelectDescription: String = "#888888"
	// 게임 배경
	static let gameBackground: String = "#F7F7F2" // 크림 (전체)
	static let gameHeader: String = "#FF6B6B"  // 빨강 (헤더)

	// 게임 문제 표시 영역
	static let questionBackground: String  = "#FFF8F8"  // 연한 핑크
	static let questionText: String = "#0B2D39"  // 진한 네이비 (숫자)
	static let operatorText: String = "#FF6B6B"  // 빨강 (연산자)
	static let answerBox: String = "#FF6B6B"  // 빨강 (입력 박스 테두리)

	// 키패드 - 숫자
	static let digitKey: String = "#FFFFFF"  // 흰색
	static let digitKeyText: String = "#0B2D39"  // 네이비
	static let digitKeyBorder: String = "#E8E0E0"  // 연한 회색

	// 키패드 - 액션
	static let deleteKey: String = "#FFBF69"  // 앰버 (한칸삭제)
	static let deleteKeyText: String = "#633806"  // 진한 갈색
	static let deleteAllKey: String = "#FFE8CC"  // 연한 오렌지 (전체삭제)
	static let deleteAllKeyText: String = "#854F0B"  // 갈색
	static let confirmKey: String = "#1FB6AA"  // 틸 (확인)
	static let confirmKeyText: String = "#FFFFFF"  // 흰색

}
