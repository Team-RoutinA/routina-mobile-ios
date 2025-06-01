//
//  DoNoAlarmView.swift
//  routina-mobile-ios
//
//  Created by 이재혁 on 6/1/25.
//

import SwiftUI

struct DoNoAlarmView: View {
    @ObservedObject var alarmViewModel: AlarmViewModel
    @ObservedObject var routineViewModel: RoutineViewModel
    @State private var isPresentingCreateAlarmView = false
    @State private var isPresentingCreateRoutineView = false
    
    var body: some View {
        NavigationStack {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("아직 알람이 없으시네요")
                        .font(.routina(.h1))
                    Text("지금 바로 시작해 보세요!")
                        .font(.routina(.body_sb16))
                }
                Spacer()
            }
            .padding(.horizontal, 24)
            
            Spacer().frame(height: 36)
            
            HStack(spacing: 8) {
                DoCreateButton(imageName: "doCreateRoutine", text: "루틴 생성") {
                    isPresentingCreateRoutineView = true
                }
                DoCreateButton(imageName: "doCreateAlarm", text: "알람 생성") {
                    isPresentingCreateAlarmView = true
                }
            }
        }
        .fullScreenCover(isPresented: $isPresentingCreateAlarmView) {
            NavigationStack {
                CreateAlarmView(alarmViewModel: alarmViewModel, routineViewModel: routineViewModel)
            }
        }
        .fullScreenCover(isPresented: $isPresentingCreateRoutineView) {
            NavigationStack {
                CreateRoutineView(viewModel: routineViewModel)
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .alarmCreated)) { _ in
            isPresentingCreateAlarmView = false
            print("[Do] 알람 생성 완료 - CreateAlarmView 닫힘")
        }

    }
}

#Preview {
    DoNoAlarmView(alarmViewModel: AlarmViewModel(), routineViewModel: RoutineViewModel())
}
