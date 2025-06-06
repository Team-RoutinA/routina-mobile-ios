//
//  AlarmScreenView.swift
//  routina-mobile-ios
//
//  Created by 이재혁 on 6/1/25.
//

import SwiftUI

struct AlarmScreenView: View {
    @State private var isPresentingExecutionView = false
    @StateObject var alarmViewModel = AlarmViewModel()

    let alarmId: String
    
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
        return formatter.string(from: alarmViewModel.selectedSpecificAlarm?.alarmTime ?? Date())
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
                    if let alarmModel = alarmViewModel.selectedSpecificAlarm {
                        alarmViewModel.startAlarm(model: alarmModel) { success, execId in
                            if success, let execId = execId {
                                isPresentingExecutionView = true
                            } else {
                                print("###실패###")
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            alarmViewModel.fetchSpecificAlarm(id: alarmId)
        }
        .toolbar(.hidden)
        .fullScreenCover(isPresented: $isPresentingExecutionView) {
            if let alarm = alarmViewModel.selectedSpecificAlarm {
                NavigationStack {
                    if let routines = alarm.routineDetails {
                        RoutineExecutionView(alarmModel: alarm, routines: routines)
                    }
                }
            }
        }
        
    }
}

//#Preview {
//    AlarmScreenView(alarmModel: AlarmModel(
//        alarmTime: Calendar.current.date(from: DateComponents(hour: 19, minute: 20)) ?? Date(),
//        weekdays: ["월", "화"],
//        routines: [],
//        isOn: true,
//        volume: 0.5,
//        isVibrationOn: true
//    ))
//}
