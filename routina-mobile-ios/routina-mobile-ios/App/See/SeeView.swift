//
//  SeeView.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/28/25.
//

import SwiftUI

struct SeeView: View {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var viewModel = CalendarViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("나의 루틴 리포트")
                .font(.routina(.h1))
                .foregroundColor(.black)
                .padding(.vertical, 32)
            
            CalendarView(viewModel: viewModel)
                .frame(width: 345, height: 380)
                .padding(.top, 4)
            
            WeeklyProgressBox(progress: viewModel.currentWeekProgress)
                .padding(.top, 24)
            Spacer()
        }
        .onAppear {
            viewModel.fetchCalendarData()
            viewModel.fetchWeeklyFeedbackProgress()
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                viewModel.fetchCalendarData()
                viewModel.fetchWeeklyFeedbackProgress()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

#Preview {
    SeeView()
}
