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
