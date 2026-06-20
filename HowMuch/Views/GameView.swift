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
                HeaderView(geo: geometry)
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
    private func HeaderView(geo: GeometryProxy) -> some View {
		HStack {
            Text("\(vm.currentLevel.id) 단계")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.leading)
                .padding(.leading)
            Spacer()
            HStack {
                ForEach(0..<15) { index in
                    if index < vm.questions.count {
                        if let didAnswerCorrectly = vm.questions[index].isCorrect {
                            if didAnswerCorrectly {
                                Circle()
                                    .fill(.white)
                                    .scaleEffect(1.7)
                                    .overlay {
                                        Image(systemName: "checkmark")
                                            .resizable()
                                            .scaledToFit()
                                            .scaleEffect(1.5)
                                            .foregroundStyle(.mint)
                                    }
                            } else {
                                Circle()
                                    .fill(.gray.opacity(0.5))
                                    .scaleEffect(1.7)
                                    .overlay {
                                        Image(systemName: "circle")
                                            .resizable()
                                            .scaledToFit()
                                            .scaleEffect(1.5)
                                            .foregroundStyle(.pink)
                                    }
                            }
                        } else {
                            Circle()
                                .fill(.gray.opacity(0.5))
                                .scaleEffect(1.7)
                                .font(.title)
                        }//:CONDITIONAL
                    }//:CONDITIONAL
                } //:LOOP
            } //:HSTACK
            
            Spacer()
            
            Text("\(vm.correctCount) / 15")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.trailing)
                .padding(.trailing)
            
            
		} //:HSTACK
        .padding(.bottom)
        .padding(.bottom)
	}
	
	@ViewBuilder
	private func QuestionView() -> some View {
		
	}
	
	@ViewBuilder
	private func KeypadView() -> some View {
		
	}
}

#Preview {
    let vm = GameViewModel()
    vm.startGame(level: .one)
    return GameView()
        .environment(vm)
}
