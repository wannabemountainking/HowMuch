//
//  GameView.swift
//  HowMuch
//
//  Created by YoonieMac on 6/17/26.
//

import SwiftUI


/// 문제 풀기 화면
struct GameView: View {
	
	@Environment(GameViewModel.self) private var vm
		
    var body: some View {
		GeometryReader { geometry in
			VStack(spacing: 0) {
				HeaderView()
					.frame(height: geometry.size.height * ComponentRatio.headerHeight)
					.background(Color(hex: HexColors.gameHeader))
				QuestionView()
					.frame(height: geometry.size.height * ComponentRatio.questionAreaHeight)
				KeypadView()
					.frame(height: geometry.size.height * ComponentRatio.keypadAreaHeight)
			} //:VSTACK
		} //:GEOMETRY
    }
	
	@ViewBuilder
	private func HeaderView() -> some View {
		HStack {
			Text("\(vm.currentLevel.id) 단계")
				.font(.system(size: ))
		}
	}
	
	@ViewBuilder
	private func QuestionView() -> some View {
		
	}
	
	@ViewBuilder
	private func KeypadView() -> some View {
		
	}
}

#Preview {
    GameView()
}
