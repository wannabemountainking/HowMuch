//
//  KeyButton.swift
//  HowMuch
//
//  Created by YoonieMac on 6/20/26.
//

import SwiftUI

struct KeyButton: View {
	
	@Environment(GameViewModel.self) private var vm
	let key: Key
	let fontSize: CGFloat
	
    var body: some View {
		Button(
			action: {
				switch key {
				case .digit(let number): vm.userInput.append("\(number)")
				case .delete: vm.userInput.removeLast()
				case .deleteAll: vm.userInput = ""
				case .confirm: vm.checkAnswer()
				case .none: print("you pressed inactive Button")
				}
			},
			label: {
				Text(key.text)
					.font(.system(size: fontSize))
					.foregroundStyle(Color(hex: key.keyTextColor))
					.background(Color(hex: key.keyBackground))
			}
		)
    }
}

#Preview {
	KeyButton(
		key: .delete,
		fontSize: 30
	)
	.environment(GameViewModel())
}
