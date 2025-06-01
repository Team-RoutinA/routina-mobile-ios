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
    
    @State private var isAlarmExist: Bool = true
            
    var body: some View {
        NavigationStack {
            VStack {
                Spacer().frame(height: 36)
                WelcomeBox(name: "박상혁") {
                    selectedTab = 2
                }
                
                Spacer().frame(height: 28)
                
                if isAlarmExist {
                    ExistAlarmView(alarmViewModel: alarmViewModel, routineViewModel: routineViewModel, alarmModel: AlarmModel(
                        alarmTime: Calendar.current.date(from: DateComponents(hour: 20, minute: 26)) ?? Date(),
                        weekdays: Set(["월", "화", "수"]),
                        routines: [],
                        isOn: true,
                        volume: 0.5,
                        isVibrationOn: true
                    ))
                } else {
                    DoNoAlarmView(alarmViewModel: alarmViewModel, routineViewModel: routineViewModel)
                }
                Spacer()
            }
            .background(.gray1)
        }
        
        
    }
}

#Preview {
    StatefulPreviewWrapper(1) { binding in
        DoView(selectedTab: binding)
    }
}
