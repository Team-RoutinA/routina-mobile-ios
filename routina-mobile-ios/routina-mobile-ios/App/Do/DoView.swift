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
    
    var body: some View {
        NavigationStack {
                VStack {
                    Spacer().frame(height: 36)
                    WelcomeBox(name: "박상혁") {
                        selectedTab = 2
                    }
                    
                    Spacer().frame(height: 28)
                    
                    if !alarmViewModel.alarms.isEmpty {
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
                }
        }
    }
}

#Preview {
    StatefulPreviewWrapper(1) { binding in
        DoView(selectedTab: binding)
    }
}
