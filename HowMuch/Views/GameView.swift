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
    
    let rows: [[Key]] = [
        [.deleteAll, .delete],
        [.digit(2), .digit(3), .digit(4), .digit(5)],
        [.digit(1), .digit(0), .digit(6)],
        [.digit(9), .digit(8), .digit(7), .none],
        [.confirm]
    ]
		
    var body: some View {
		GeometryReader { geometry in
			VStack(spacing: 0) {
                HeaderView(geo: geometry)
					.frame(height: geometry.size.height * ComponentRatio.headerHeight)
					.background(Color(hex: HexColors.gameHeader))
				QuestionView(geo: geometry)
					.frame(height: geometry.size.height * ComponentRatio.questionAreaHeight)
                    .background(Color(hex: HexColors.questionBackground))
				KeypadView(geo: geometry)
					.frame(height: geometry.size.height * ComponentRatio.keypadAreaHeight)
			} //:VSTACK
			.background(Color(hex: HexColors.gameBackground))
		} //:GEOMETRY
    }
	
	@ViewBuilder
    private func HeaderView(geo: GeometryProxy) -> some View {
		HStack {
            Text("\(vm.currentLevel.id) 단계")
				.font(
					.system(
						size: geo.size.height * ComponentRatio.headerHeight * 0.5,
						weight: .semibold,
						design: .rounded
					)
				)
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
									.frame(height: geo.size.height * ComponentRatio.headerHeight * 0.6)
									.overlay(alignment: .center) {
                                        Image(systemName: "checkmark")
                                            .resizable()
                                            .scaledToFit()
											.frame(height: geo.size.height * ComponentRatio.headerHeight * 0.4)
                                            .foregroundStyle(.mint)
                                    }
                            } else {
                                Circle()
                                    .fill(.white.opacity(0.6))
									.frame(height: geo.size.height * ComponentRatio.headerHeight * 0.5)
									.overlay(alignment: .center) {
                                        Image(systemName: "circle")
                                            .resizable()
                                            .scaledToFit()
											.frame(height: geo.size.height * ComponentRatio.headerHeight * 0.3)
											.foregroundStyle(.red)
                                    }
                            }
                        }//:CONDITIONAL
					}//:CONDITIONAL
                } //:LOOP
            } //:HSTACK
            
            Spacer()
            
            Text("\(vm.correctCount) / 15")
				.font(
					.system(
						size: geo.size.height * ComponentRatio.headerHeight * 0.5,
						weight: .semibold,
						design: .rounded
					)
				)
                .foregroundStyle(.white)
                .padding(.trailing)
                .padding(.trailing)
            
            
		} //:HSTACK
        .padding(.bottom)
        .padding(.bottom)
	}
	
	@ViewBuilder
	private func QuestionView(geo: GeometryProxy) -> some View {
		if let question = vm.questions.last {
			HStack(alignment: .center) {
				HStack(alignment: .center, spacing: 20) {
					Text("\(question.lhs)")
					Image(systemName: question.operation.symbol)
						.font(.system(size: geo.size.height * ComponentRatio.questionFontSize * 0.9))
                        .foregroundStyle(Color(hex: HexColors.operatorText))
					Text("\(question.rhs)")
					Image(systemName: "equal")
                        .font(.system(size: geo.size.height * ComponentRatio.questionFontSize * 0.9))
                        .foregroundStyle(Color(hex: HexColors.operatorText))
					RoundedRectangle(cornerRadius: 15)
                        .strokeBorder(Color.red, lineWidth: 5)
						.frame(
                            width:  geo.size.height * ComponentRatio.questionFontSize * 1.2,
                            height: geo.size.height * ComponentRatio.questionFontSize * 1.2
						)
						.overlay {
							Text(vm.userInput)
						}
						.background(Color.white)
				}  //:HSTACK
                .font(
                    .system(
                        size: geo.size.height * ComponentRatio.questionFontSize * 1.3,
                        weight: .semibold,
                        design: .rounded
                    )
                )
                .fontWeight(.black)
				.frame(height: geo.size.height * ComponentRatio.questionAreaHeight * 0.8)
                .foregroundStyle(Color(hex: HexColors.questionText))
			} //:HSTACK
			.frame(height: geo.size.height * ComponentRatio.questionAreaHeight)
		}//:CONDITIONAL
	}
	
	@ViewBuilder
    private func KeypadView(geo: GeometryProxy) -> some View {
        VStack {
            Grid(horizontalSpacing: 10, verticalSpacing: 10) {
                ForEach(rows, id: \.self) { row in
                    GridRow {
                        ForEach(row, id: \.self) { key in
                            ZStack(alignment: .center) {

                            }
                        }
                    }
                }
            }
        } //:VSTACK
	}
}

#Preview {
    let vm = GameViewModel()
    vm.startGame(level: .one)
	
	// 몇 개 문제에 답 상태 직접 주입
	vm.questions[0].isCorrect = true
	vm.questions[0].isCorrect = false  // 오답도 테스트
	
    return GameView()
        .environment(vm)
}
