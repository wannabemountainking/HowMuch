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
				
				VStack(alignment: .center, spacing: 30) {
					Image(vm.resultImageName)
						.resizable()
						.scaledToFit()
						.frame(height: geo.size.height / 2.5)
						.padding(20)
					RoundedRectangle(cornerRadius: geo.size.height * ComponentRatio.resultCardCornerRadius)
						.frame(width: geo.size.width * ComponentRatio.resultCardWidth, height: geo.size.height * ComponentRatio.resultCardHeight)
						.foregroundStyle(Color(hex: HexColors.resultCard))
						.overlay(alignment: .center) {
							VStack(alignment: .center, spacing: 10) {
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
								.overlay(alignment: .bottom) {
									GeometryReader { scoreGeo in
										RoundedRectangle(cornerRadius: 6)
											.frame(
												width: scoreGeo.size.width,
												height: 6
											)
											.foregroundStyle(Color(hex: HexColors.resultDivider))
											.offset(y: scoreGeo.size.height * 0.95)
									}
								}
                                
								HStack(alignment: .lastTextBaseline) {
									Text("\(vm.score)")
										.font(.system(size: geo.size.height * ComponentRatio.resultSubScoreFontSize, weight: .medium, design: .rounded))
									Text("점")
										.font(.custom("Fredoka", size: geo.size.height * ComponentRatio.resultButtonHeight))
								}
								.foregroundStyle(Color(hex: HexColors.resultSlash))
								
							}
							
						} // : Card
					
					VStack(spacing: 20) {
						Button {
							//action
							vm.retry()
						} label: {
							Text("틀린 문제 다시 풀기")
								.font(.custom("Fredoka", size: geo.size.height * 0.04))
								.frame(
									width: geo.size.width * ComponentRatio.resultButtonWidth,
									height: geo.size.height * ComponentRatio.resultButtonHeight,
								)
								.foregroundStyle(.white)
								.padding(12)
								.background(Color(hex: HexColors.resultRetryButton))
								.clipShape(
									RoundedRectangle(cornerRadius: 20)
								)
							
						}
						
						Button {
							// action
							vm.quit()
						} label: {
							Text("그만하기")
								.font(.custom("Fredoka", size:  geo.size.height * 0.04))
								.frame(
									width: geo.size.width * ComponentRatio.resultButtonWidth,
									height: geo.size.height * ComponentRatio.resultButtonHeight,
								)
								.foregroundStyle(.white)
								.padding(12)
								.background(Color(hex: HexColors.resultRetryButton))
								.clipShape(
									RoundedRectangle(cornerRadius: 20)
								)
						}

					} //:VSTACK
				} //:VSTACK
				.padding(.bottom, 20)
			} //:ZSTACK
		} //:GEOMETRY
    }
}


#Preview {
    ResultView()
		.environment(GameViewModel())
}
