//
//  ContentView.swift
//  HowMuch
//
//  Created by YoonieMac on 6/17/26.
//

import SwiftUI

struct IntroView: View {
	
	@State private var vm: GameViewModel = .init()
	
    var body: some View {
		ZStack {
			switch vm.currentScreen {
				case .levelSelect: LevelSelectView()
				case .game: GameView()
				case .result: ResultView()
			} //:CONDITION
		} //:ZSTACK
		.environment(vm)
		.animation(.easeInOut, value: vm.currentScreen)
    }//:body
}

#Preview {
    IntroView()
}
