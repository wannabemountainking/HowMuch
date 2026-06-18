//
//  LevelSelectionView.swift
//  HowMuch
//
//  Created by YoonieMac on 6/17/26.
//

import SwiftUI


// 단계 선택 화면(intro)
struct LevelSelectView: View {
    
    @State private var vm: GameViewModel = .init()
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
            VStack(alignment: .center, spacing: 50) {
                VStack(spacing: 20) {
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
                .padding(.top, 50)
                
                ScrollView {
                    LazyVGrid(
                        columns: columns,
                        spacing: 30,
                        pinnedViews: .sectionHeaders,
                        content: {
                            ForEach(Array(Level.allCases), id: \.id) { level in
                                CardView(level: level)
                            } //:LOOP
                        }//: Content
                    )//: LazyVGrid
                    .scrollDisabled(true)
                } //:SCROLL
            } //:VSTACK
            .padding(.horizontal, 60)
            .padding(.bottom, 60)
        } //:ZSTACK
    }
    
    @ViewBuilder
    private func CardView(level: Level) -> some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            .foregroundStyle(Color.white)
            .overlay(alignment: .center) {
                VStack(alignment: .center, spacing: 50) {
                    Text("\(level.id)단계")
                        .font(.system(size: 48))
                        .fontWeight(.bold)
                        .foregroundStyle(Color(hex: HexColors.levelSelectGrade))
                        .kerning(4)
                    Text(level.description)
                        .font(.title)
                        .fontWeight(.light)
                        .foregroundStyle(Color(hex: HexColors.levelSelectDescription))
                }
            }
    }
}

#Preview {
    LevelSelectView()
}
