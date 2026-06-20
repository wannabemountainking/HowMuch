//
//  KeyButton.swift
//  HowMuch
//
//  Created by YoonieMac on 6/20/26.
//

import SwiftUI

struct KeyButton: View {
	
	let key: Key
	
    var body: some View {
		GeometryReader { geometry in
			Button(
				action: {
					
				},
				label: {
					switch key {
					case .digit(let number): Text("\(number)")
					case .delete: Text("입력 숫자 삭제")
					case .deleteAll: Text("모든 입력 숫자 삭제")
					case .confirm: Text("확인")
					}
				}
			)
		} //:GEOMETRY
    }
}

#Preview {
    KeyButton()
}
