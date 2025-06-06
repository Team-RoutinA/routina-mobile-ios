//
//  DoView.swift
//  routina-mobile-ios
//
//  Created by 이재혁 on 5/25/25.
//

import SwiftUI

struct DoView: View {
    @Binding var selectedTab: Int
    
    @StateObject private var alarmViewModel = AlarmViewModel()
    @StateObject private var routineViewModel = RoutineViewModel()
    @State private var moveToRoutine = false
    @State private var selectedAlarmModel: AlarmModel? = nil
    
    var body: some View {
        NavigationStack {
                VStack {
                    Spacer().frame(height: 36)
                    WelcomeBox(name: "박상혁") {
                        selectedTab = 2
                    }
                    
                    Spacer().frame(height: 28)
                    
                    let filteredAlarms = alarmViewModel.filteredAlarms()
                    
                    if !filteredAlarms.isEmpty {
                        ExistAlarmView(alarmViewModel: alarmViewModel, routineViewModel: routineViewModel)
                    } else {
                        DoNoAlarmView(alarmViewModel: alarmViewModel, routineViewModel: routineViewModel)
                    }
                    Spacer()
                }
                .background(.gray1)
                .onAppear {
                    routineViewModel.fetchRoutines { routines in
                        alarmViewModel.updateRoutineMap(routines)
                        alarmViewModel.fetchAlarms()
                    }
//                    if UserDefaults.standard.bool(forKey: "launchFromNotification") {
//                        routineViewModel.fetchRoutines { routines in
//                            alarmViewModel.updateRoutineMap(routines)
//                            alarmViewModel.fetchAlarms()
//                            
//                            // fetch 후 알람이 있을 때만 화면 전환
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                                if let first = alarmViewModel.alarms.first {
//                                    selectedAlarmModel = first
//                                    moveToRoutine = true
//                                }
//                            }
//                        }
//                        UserDefaults.standard.set(false, forKey: "launchFromNotification") // 재사용 대비 초기화
//                    } else {
//                        routineViewModel.fetchRoutines { routines in
//                            alarmViewModel.updateRoutineMap(routines)
//                            alarmViewModel.fetchAlarms()
//                        }
//                    }
                }
            
            ///--------------------------------
            /// 알림기능 테스트 위한 임시 코드
            
//            Button("5초 후 루틴 알림 예약") {
//                let date = Calendar.current.date(byAdding: .second, value: 5, to: Date())!
//                NotificationService.scheduleNotification2(at: date)
//            }
//            .navigationDestination(isPresented: $moveToRoutine) {
//                if let alarm = selectedAlarmModel {
//                    AlarmScreenView(alarmModel: alarm)
//                }
//            }
        }
//        .onReceive(NotificationCenter.default.publisher(for: .navigateToRoutine)) { _ in
//            if let first = alarmViewModel.alarms.first {
//                selectedAlarmModel = first
//                moveToRoutine = true
//            }
//        }
        
        //---------------------------------
    }
}

#Preview {
    StatefulPreviewWrapper(1) { binding in
        DoView(selectedTab: binding)
    }
}
