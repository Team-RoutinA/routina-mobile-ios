//
//  plan.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/25/25.
//
import SwiftUI

struct PlanView: View {
    @StateObject private var alarmViewModel = AlarmViewModel()
    @StateObject private var routineViewModel = RoutineViewModel()
    
    @State private var selectedTab: String = "알람"

    var body: some View {
        VStack(spacing: 10) {
            TopTabBar(selectedTab: $selectedTab)
                .frame(maxWidth: .infinity)
                .background(Color.white.ignoresSafeArea(edges: .top))
                .zIndex(1)

            if selectedTab == "알람" {
                AlarmView(alarmViewModel: alarmViewModel, routineViewModel: routineViewModel)
            } else {
                RoutineView(viewModel: routineViewModel)
            }
        }
        .background(Color.gray1)
    }
}

#Preview {
    PlanView()
}
