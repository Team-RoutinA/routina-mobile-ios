//
//  TimeRoutineView.swift
//  routina-mobile-ios
//
//  Created by 이재혁 on 6/1/25.
//

import SwiftUI

struct TimeRoutineView: View {
    @ObservedObject var viewModel: RoutineViewModel
    let routine: RoutineDetail
    let onComplete: () -> Void
    @State private var remainingTime: Int = 0
    @State private var isRunning = true
    @State private var timer: Timer?
    
    var body: some View {
        VStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.sub3Blue, .white]), startPoint: .top, endPoint: .bottom)
                    .frame(width: UIScreen.main.bounds.width, height: 360)
                Image(.timeIcon)
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

                Text(String(format: "%02d:%02d", remainingTime / 60, remainingTime % 60))
                    .font(.PretendardExtraBold40)
                
                //RoutineProceedButton(text: "일시 중지", enable: true, action: onComplete)
                RoutineProceedButton(
                    text: remainingTime > 0 ? (isRunning ? "일시 중지" : "다시 시작") : "완료",
                    enable: true,
                    action: {
                        if remainingTime == 0 {
                            viewModel.completeRoutines(routine.routine_id)
                            onComplete()
                        } else {
                            isRunning.toggle()
                        }
                    }
                )
            }
        }
        .onAppear {
            remainingTime = (routine.goal_value ?? 1) * 60
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                if isRunning && remainingTime > 0 {
                    remainingTime -= 1
                }
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
}

//#Preview {
//    TimeRoutineView(routine: RoutineModel(
//        title: "스트레칭 5분",
//        icon: "time",
//        routineType: .time,
//        goalCount: 1,
//        limitMinutes: 60,
//        successStandard: "충분히 당기는 느낌이 들 때 까지 눌러주기"
//    )) {}
//}
