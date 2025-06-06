//
//  routina_mobile_iosApp.swift
//  routina-mobile-ios
//
//  Created by 이재혁 on 5/25/25.
//

import SwiftUI

@main
struct routina_mobile_iosApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @State private var moveToRoutine = false
    @State private var selectedAlarmId: String? = nil
    
    @Environment(\.scenePhase) private var scenePhase
    
    init() {
        NotificationService.requestPermission()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RootView()
                    .onAppear {
                        print("APPEAR")
                        if UserDefaults.standard.bool(forKey: "launchFromNotification") {
                            let routineViewModel = RoutineViewModel()
                            routineViewModel.fetchRoutines { routines in
                                let alarmViewModel = AlarmViewModel()
                                alarmViewModel.fetchAlarms()
                                alarmViewModel.updateRoutineMap(routines)
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    selectedAlarmId = UserDefaults.standard.string(forKey: "launchedAlarmId")
                                    moveToRoutine = true
                                }
                            }
                            UserDefaults.standard.set(false, forKey: "launchFromNotification") // 재사용 대비 초기화
                        }
                    }
                    .onReceive(NotificationCenter.default.publisher(for: .navigateToRoutine)) { _ in
                        let alarmViewModel = AlarmViewModel()
                        alarmViewModel.fetchAlarms()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            selectedAlarmId = UserDefaults.standard.string(forKey: "launchedAlarmId")
                            moveToRoutine = true
                        }
                    }
                    .onChange(of: scenePhase) {
                        print("NEW PHASE: \(scenePhase)")
                        if scenePhase == .active {
                            if UserDefaults.standard.bool(forKey: "launchFromNotification") {
                                let routineViewModel = RoutineViewModel()
                                routineViewModel.fetchRoutines { routines in
                                    let alarmViewModel = AlarmViewModel()
                                    alarmViewModel.fetchAlarms()
                                    alarmViewModel.updateRoutineMap(routines)
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        selectedAlarmId = UserDefaults.standard.string(forKey: "launchedAlarmId")
                                        moveToRoutine = true
                                    }
                                }
                                UserDefaults.standard.set(false, forKey: "launchFromNotification") // 재사용 대비 초기화
                            }
                        }
                    }
                    .navigationDestination(isPresented: $moveToRoutine) {
                        if let alarmId = selectedAlarmId {
                            AlarmScreenView(alarmId: alarmId)
                        }
                    }
            }
        }
    }
}
