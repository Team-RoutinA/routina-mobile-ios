//
//  SimpleRoutineView.swift
//  routina-mobile-ios
//
//  Created by 이재혁 on 6/1/25.
//

import SwiftUI

struct SimpleRoutineView: View {
    let routine: RoutineModel
    let onComplete: () -> Void
    
    var body: some View {
        VStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.sub3Blue, .white]), startPoint: .top, endPoint: .bottom)
                    .frame(width: .infinity, height: 360)
                Image(.simpleIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 128, height: 128)
            }
            
            Spacer().frame(height: 48)
            
            VStack(spacing: 55) {
                VStack(spacing: 8) {
                    Text(routine.title)
                        .font(.routina(.h1))

                    Text(routine.successStandard!)
                        .font(.routina(.body_r16))
                }

                Text("지금 하세요")
                    .font(.PretendardExtraBold40)
                
                RoutineProceedButton(text: "완료", enable: true, action: onComplete)
            }
        }
    }
}

#Preview {
    SimpleRoutineView(routine: RoutineModel(
        title: "물 한 잔 마시기",
        icon: "simple",
        routineType: .simple,
        goalCount: nil,
        limitMinutes: 30,
        successStandard: "미지근한 물로 250ml 이상 마시기!"
    )) {}
}
