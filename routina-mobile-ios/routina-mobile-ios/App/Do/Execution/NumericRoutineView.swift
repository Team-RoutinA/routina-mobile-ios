//
//  NumericRoutineView.swift
//  routina-mobile-ios
//
//  Created by 이재혁 on 6/1/25.
//

import SwiftUI

struct NumericRoutineView: View {
    let routine: RoutineDetail
    let onComplete: () -> Void
    
    var body: some View {
        VStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.sub3Blue, .white]), startPoint: .top, endPoint: .bottom)
                    .frame(width: UIScreen.main.bounds.width, height: 360)
                Image(.numericIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 128, height: 128)
            }
            
            Spacer().frame(height: 48)
            
            VStack(spacing: 55) {
                VStack(spacing: 8) {
                    Text(routine.title)
                        .font(.routina(.h1))

                    Text(routine.success_note)
                        .font(.routina(.body_r16))
                }

                Text("x\(routine.goal_value ?? 0)")
                    .font(.PretendardExtraBold40)
                
                RoutineProceedButton(text: "완료", enable: true, action: onComplete)
            }
        }
    }
}

//#Preview {
//    NumericRoutineView(routine: RoutineModel(
//        title: "푸시업 10개",
//        icon: "numeric",
//        routineType: .numeric,
//        goalCount: 10,
//        limitMinutes: 60,
//        successStandard: "1개 = 팔꿈치 각도 90도"
//    )) {}
//}
