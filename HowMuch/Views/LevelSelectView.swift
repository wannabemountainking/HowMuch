//
//  LevelSelectionView.swift
//  HowMuch
//
//  Created by YoonieMac on 6/17/26.
//

import SwiftUI


// 단계 선택 화면(intro)
struct LevelSelectView: View {
    
	@Environment(GameViewModel.self) var vm
	
    let columns = [
        GridItem(.flexible(), spacing: 30),
        GridItem(.flexible(), spacing: 30)
    ]
    
    var body: some View {
        ZStack {
            // Background Color
            Color(hex: HexColors.levelSelectBackground)
                .ignoresSafeArea()
            // Content
            VStack(alignment: .center, spacing: 20) {
                VStack(spacing: 10) {
                    Image(systemName: "pencil.and.outline")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundStyle(Gradient(colors: [.mint, .yellow]))
                    
                    Text("숫자 놀이!")
                        .font(.system(size: 64))
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .kerning(5)
                        .lineSpacing(20)
                    Text("단계를 고르세요")
                        .font(.system(size: 36))
                        .fontWeight(.medium)
                        .foregroundStyle(.white)
                        .kerning(2)
                } //:VSTACK
				.padding(.vertical, 30)
                
				GeometryReader { geometry in
					VStack(spacing: 60) {
						HStack(spacing: 60) {
							CardView(level: .one)
							CardView(level: .two)
						}
						HStack(spacing: 60) {
							CardView(level: .three)
							CardView(level: .four)
						}
					} //:VSTACK
				}// : GeometryReader
				.frame(maxHeight: .infinity)
            } //:VSTACK
			.padding(20)
            .padding(.horizontal, 60)
            .padding(.bottom, 60)
        } //:ZSTACK
    }
    
    @ViewBuilder
    private func CardView(level: Level) -> some View {
        RoundedRectangle(cornerRadius: 25)
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.foregroundStyle(Color.white)
            .overlay(alignment: .center) {
                VStack(alignment: .center) {
					Spacer()
					Spacer()
                    Text("\(level.id)단계")
                        .font(.system(size: 36))
                        .fontWeight(.bold)
                        .foregroundStyle(Color(hex: HexColors.levelSelectGrade))
                        .kerning(4)
					Spacer()
                    Text(level.description)
						.font(.system(size: 24))
                        .fontWeight(.light)
                        .foregroundStyle(Color(hex: HexColors.levelSelectDescription))
					Spacer()
					Spacer()
                }
            }
			.onTapGesture {
				vm.startGame(level: level)
			}
    }
}



#Preview {
    LevelSelectView()
		.environment(GameViewModel())
}
