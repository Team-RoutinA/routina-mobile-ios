//
//  SplashView.swift
//  routina-mobile-ios
//
//  Created by 이재혁 on 6/8/25.
//

import SwiftUI

struct SplashView: View {
    @Binding var isLoggedIn: Bool
    @State private var isActive = false
    @State private var circleRotation: Double = -180
    @State private var circleOffset: CGFloat = -100
    @State private var characterOffset: CGFloat = 100
    
    var body: some View {
        if isActive {
            WelcomeView(isLoggedIn: $isLoggedIn)
        } else {
            ZStack {
                Color(.sub2Blue)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    ZStack {
                        Image(.splashCircle)
                            .frame(width: 201, height: 201)
                            .rotationEffect(.degrees(circleRotation))
                            .offset(x: circleOffset, y: -10)
                        
                        Image(.routinaCharacter)
                            .resizable()
                            .frame(width: 234, height: 256)
                            .offset(x: characterOffset, y: 10)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("루티나")
                            .font(.PretendardMedium40)
                            .foregroundColor(.white)
                        
                        Text("RoutinA")
                            .font(.PretendardBold40)
                            .foregroundColor(.white)
                        
                        Text("알람과 함께 시작하는 아침 루틴 관리 에이전트")
                            .font(.PretendardMedium14)
                            .foregroundColor(.white)
                    }
                }
            }
            .onAppear {
                withAnimation(.easeOut(duration: 1.0)) {
                    circleOffset = -10
                    circleRotation = 0
                }

                withAnimation(.interpolatingSpring(stiffness: 100, damping: 10).delay(0.3)) {
                    characterOffset = 10
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

//#Preview {
//    SplashView()
//}
