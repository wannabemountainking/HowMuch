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
			Color(hex: HexColors.mainBackground)
                .ignoresSafeArea()
            // Content
            VStack(alignment: .center, spacing: 20) {
                VStack(spacing: 10) {
                    Image(systemName: "pencil.and.outline")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 120)
                        .foregroundStyle(Gradient(colors: [.yellow, .mint]))
					
                    Text("숫자 놀이!")
						.font(.custom("Cafe24 Ssurround", size: 90))
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .kerning(5)
                        .lineSpacing(20)
                    Text("단계를 고르세요")
                        .font(.custom("Fredoka", size: 36))
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
                        .font(.custom("Cafe24 Ssurround", size: 48))
                        .fontWeight(.bold)
                        .foregroundStyle(Color(hex: HexColors.levelSelectGrade))
                        .kerning(4)
					Spacer()
                    Text(level.description)
						.font(.custom("Nunito_SemiBold", size: 24))
                        .fontWeight(.light)
                        .foregroundStyle(Color(hex: HexColors.levelSelectDescription))
					Spacer()
					Spacer()
                }
            }
			.shadow(radius: 15, x: 15, y: 15)
			.onTapGesture {
				vm.startGame(level: level)
			}
    }
}



#Preview {
    LevelSelectView()
		.environment(GameViewModel())
}
