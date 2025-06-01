//
//  DoView.swift
//  routina-mobile-ios
//
//  Created by 이재혁 on 5/25/25.
//

import SwiftUI

struct DoView: View {
    @StateObject private var alarmViewModel = AlarmViewModel()
    @StateObject private var routineViewModel = RoutineViewModel()
    
    @State private var isAlarmExist: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer().frame(height: 36)
                WelcomeBox(name: "박상혁") {}
                
                Spacer().frame(height: 28)
                
                if isAlarmExist {
                    
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
    DoView()
}
