//
//  AlarmScreenView.swift
//  routina-mobile-ios
//
//  Created by 이재혁 on 6/1/25.
//

import SwiftUI

struct AlarmScreenView: View {
    @ObservedObject var viewModel: RoutineViewModel = RoutineViewModel()
    @State private var isPresentingExecutionView = false
    let alarmModel: AlarmModel
    
    // 날짜 포맷
    private var dateString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "M월 d일 EEEE"
        return formatter.string(from: Date())
    }
    
    // 시간 포맷
    private var timeString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: alarmModel.alarmTime)
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 54) {
                Spacer()
                
                VStack(spacing: 0) {
                    Text(dateString)
                        .font(.routina(.h1))
                    Text(timeString)
                        .font(.PretendardBold72)
                }
                
                Spacer()
                
                Image(.routinaLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 256, height: 256)
                
                Spacer()
                
                MainButton(text: "알람 끄기") {
                    isPresentingExecutionView = true
                }
            }
        }
        .fullScreenCover(isPresented: $isPresentingExecutionView) {
            NavigationStack {
                RoutineExecutionView(alarmTime: alarmModel.alarmTime, routineViewModel: viewModel)
            }
        }
    }
}

#Preview {
    AlarmScreenView(alarmModel: AlarmModel(
        alarmTime: Calendar.current.date(from: DateComponents(hour: 19, minute: 20)) ?? Date(),
        weekdays: ["월", "화"],
        routines: [],
        isOn: true,
        volume: 0.5,
        isVibrationOn: true
    ))
}
