//
//  ResultView.swift
//  HowMuch
//
//  Created by YoonieMac on 6/17/26.
//

import SwiftUI


/// 결과 확인
struct ResultView: View {
	
	@Environment(GameViewModel.self) private var vm
	
    var body: some View {
		GeometryReader { geo in
			ZStack(alignment: .center) {
				Color(hex: HexColors.resultBackground).ignoresSafeArea()
				
				VStack(alignment: .center, spacing: 0) {
					Image(vm.resultImageName)
						.resizable()
						.scaledToFit()
						.frame(height: geo.size.height / 2.5)
						.padding(20)
					RoundedRectangle(cornerRadius: geo.size.height * ComponentRatio.resultCardCornerRadius)
						.frame(width: geo.size.height * ComponentRatio.resultCardWidth, height: geo.size.height * ComponentRatio.resultCardHeight)
						.foregroundStyle(Color(hex: HexColors.resultCard))
						.overlay(alignment: .center) {
							VStack(alignment: .center, spacing: 20) {
								// 13/15
								HStack(alignment: .lastTextBaseline) {
									Text("\(vm.correctCount)")
										.font(
											.system(
												size: geo.size.height * ComponentRatio.resultScoreFontSize,
												weight: .bold,
												design: .rounded
											)
										)
										.foregroundStyle(Color(hex: HexColors.resultScoreText))
									Text(" / 15")
										.font(
											.system(
												size: geo.size.height * ComponentRatio.resultScoreFontSize * 0.55,
												weight: .bold,
												design: .rounded
											)
										)
										.foregroundStyle(Color(hex: HexColors.resultSlash))
								}
								Divider()
									.foregroundStyle(Color(hex: HexColors.resultDivider))
								HStack(alignment: .lastTextBaseline) {
									Text("\(vm.score)")
									Text("점")
								}
								.font(.system(size: geo.size.height * ComponentRatio.resultSubScoreFontSize, weight: .medium, design: .rounded))
								.foregroundStyle(Color(hex: HexColors.resultSlash))
								
							}
							
						} // : Card
					
					Button {
						//action
						
					} label: {
						Text("틀린 문제 다시 풀기")
							.font(.system(size: geo.size.height * 0.05, weight: .medium, design: .rounded))
							.foregroundStyle(.white)
					}

				} //:VSTACK
			} //:ZSTACK
		} //:GEOMETRY
    }
}


#Preview {
    ResultView()
		.environment(GameViewModel())
}
