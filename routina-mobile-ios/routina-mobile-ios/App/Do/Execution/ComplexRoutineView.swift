//
//  ComplexRoutineView.swift
//  routina-mobile-ios
//
//  Created by 이재혁 on 6/1/25.
//

import SwiftUI

struct ComplexRoutineView: View {
    let alarmTime: Date
    let routine: RoutineDetail
    let onComplete: () -> Void
    
    var endTimeString: String {
        let endTime = Calendar.current.date(byAdding: .minute, value: routine.duration_seconds ?? 0, to: alarmTime) ?? alarmTime
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: endTime)
    }
    
    var body: some View {
        VStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.sub3Blue, .white]), startPoint: .top, endPoint: .bottom)
                    .frame(width: UIScreen.main.bounds.width, height: 360)
                Image(.complexIcon)
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
                
                Text("\(endTimeString) 까지")
                    .font(.PretendardExtraBold40)
                
                RoutineProceedButton(text: "완료", enable: true, action: onComplete)
            }
        }
    }
}

//#Preview {
//    ComplexRoutineView(alarmTime: Date(), routine: RoutineModel(
//        title: "강아지 산책 갔다오기",
//        icon: "complex",
//        routineType: .complex,
//        goalCount: 10,
//        limitMinutes: 60,
//        successStandard: "꼭 실외배변 성공하기!!"
//    )) {}
//}
