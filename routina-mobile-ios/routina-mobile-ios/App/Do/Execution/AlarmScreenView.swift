//
//  AlarmScreenView.swift
//  routina-mobile-ios
//
//  Created by 이재혁 on 6/1/25.
//

import SwiftUI

struct AlarmScreenView: View {
    @Binding var isPresented: Bool
    @State private var execID: String?
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
    
    var isRoutineReady: Bool {
        alarmViewModel.selectedSpecificAlarm?.routineDetails != nil
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
                
                MainButton(text: "알람 끄기", enable: isRoutineReady) {
                    print("Mainbutton tapped")
                    print("###\n \(String(describing: alarmViewModel.selectedSpecificAlarm?.routineDetails ?? nil)) \n###")
                    if let alarmModel = alarmViewModel.selectedSpecificAlarm {
                        print("alarmModel loaded")
                        alarmViewModel.startAlarm(model: alarmModel) { success, execId in
                            if success, let execId = execId {
                                print("✅ execID 할당 시작")
                                self.execID = execId
                                
                            } else {
                                print("startAlarm 실패")
                            }
                        }
                    } else {
                        print("selectedSpecificAlarm이 nil입니다.")
                    }
                }
            }
        }
        .onAppear {
            alarmViewModel.fetchSpecificAlarm(id: alarmId)
        }
        .toolbar(.hidden)
        .onChange(of: execID) {
            if execID != nil {
                print("🔔 execID 변경됨: \(String(describing: execID))")
                isPresentingExecutionView = true
            }
        }
        .fullScreenCover(isPresented: $isPresentingExecutionView) {
            NavigationStack {
                if let alarm = alarmViewModel.selectedSpecificAlarm,
                   let routines = alarm.routineDetails,
                   let execID = execID {
                    RoutineExecutionView(alarmModel: alarm, routines: routines, execID: execID, dismissAlarmScreen: { isPresented = false })
                } else {
                    VStack(spacing: 16) {
                        Text("⛔️ 루틴 또는 execID 없음")
                        Text("execID: \(execID ?? "nil")")
                        Text("routines: \(alarmViewModel.selectedSpecificAlarm?.routineDetails?.count.description ?? "nil")")
                    }
                    .onAppear {
                        print("⚠️ 루틴 또는 execID 없음")
                        print("execID: \(String(describing: self.execID))")
                        print("routines: \(String(describing: alarmViewModel.selectedSpecificAlarm?.routineDetails))")
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
