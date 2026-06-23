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
                            width:  geo.size.height * ComponentRatio.questionFontSize * 3,
                            height: geo.size.height * ComponentRatio.questionFontSize * 1.5
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
            Grid(horizontalSpacing: 20, verticalSpacing: 20) {
				ForEach(rows, id: \.self) { row in
                    GridRow {
						ForEach(row, id: \.self) { key in
							switch key {
							case .digit(let num):
								keyButtonView(geo: geo, key: key) {
									vm.userInput.append(Key.digit(num).text)
								}
							case .deleteAll:
								keyButtonView(geo: geo, key: key) {
									vm.userInput = ""
								}
							case .delete:
								keyButtonView(geo: geo, key: key) {
									guard !vm.userInput.isEmpty else {return}
									vm.userInput.removeLast()
								}
							case .confirm:
								keyButtonView(geo: geo, key: key) {
									vm.checkAnswer()
									vm.nextQuestion()
								}
							case .none:
								keyButtonView(geo: geo, key: key) { }
							}
                        } //:LOOP
                    } //:GRID Row
                } //:LOOP
            }  //:GRID
        } //:VSTACK
		.padding(20)
	}
	
	@ViewBuilder
	private func keyButtonView(geo: GeometryProxy, key: Key, completion: @escaping () -> Void) -> some View {
		
		let buttonHeight = ComponentRatio.keypadAreaHeight / ComponentRatio.keyHeight
		
		Button {
			//action
			completion()
		} label: {
			Text(key.text)
				.font(
					.system(
						size: geo.size.height * ComponentRatio.keyFontSize,
						weight: .semibold,
						design: .rounded
					)
				)
				.frame(maxWidth: .infinity)
				.frame(height: geo.size.height * buttonHeight)
				.foregroundStyle(Color(hex: key.keyTextColor))
				.background(Color(hex: key.keyBackground))
				.clipShape(
					RoundedRectangle(cornerRadius: 10)
				)
				.shadow(radius: 2)
		}
		.gridCellColumns(key.gridCellColums)
		
	}
}

#Preview {
	let vm = GameViewModel()
	
	vm.startGame(level: .four)
	
    return GameView()
        .environment(vm)
}
