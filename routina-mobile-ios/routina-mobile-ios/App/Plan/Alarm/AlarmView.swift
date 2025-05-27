//
//  AlarmListView.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/25/25.
//

import SwiftUI

struct AlarmView: View {
    @ObservedObject var alarmViewModel: AlarmViewModel
    @ObservedObject var routineViewModel: RoutineViewModel
    @State private var isPresentingCreateView = false

    // 임시로 가장 가까운 알람 시간 기준 남은 시간 텍스트 계산
    var nextAlarmText: String {
        // 실제 서버 연결 시 viewModel에서 nextAlarm까지 계산
        // 여기서는 첫 번째 알람 시간 하드코딩 기준으로 예시
        return "1시간 19분 후 울려요"
    }

    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(spacing: 12) {
                    // 알람 남은 시간 텍스트
                    HStack {
                        Text(nextAlarmText)
                            .font(.routina(.h2))
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.horizontal, 50)
                    .padding(.bottom, 8)
                    
                    // 알람 생성하기 버튼
                    CreateAlarmButton(text: "+ 알람 생성하기") {
                        isPresentingCreateView = true
                    }
                    .padding(.horizontal, 24)
                    
                    // 알람 카드 리스트
                    ForEach(Array(alarmViewModel.alarms.enumerated()), id: \.0) { (index, alarm) in
                        AlarmCard(
                            timeText: alarm.timeText,
                            weekdays: Array(alarm.weekdays),
                            routines: alarm.routines,
                            isOn: $alarmViewModel.alarms[index].isOn,
                            onDelete: {
                                alarmViewModel.alarms.remove(at: index)
                            }
                        )
                        .padding(.horizontal, 48)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 18)
            }
            .background(Color.gray1.ignoresSafeArea())
        }
        .fullScreenCover(isPresented: $isPresentingCreateView) {
            NavigationStack {
                CreateAlarmView(alarmViewModel: alarmViewModel, routineViewModel: routineViewModel)
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .alarmCreated)) { _ in
            // 알람이 생성되었다는 신호를 받으면 CreateAlarmView 닫기
            isPresentingCreateView = false
            print("알람 생성 완료 - CreateAlarmView 닫힘")
        }
    }
}

#Preview {
    AlarmView(alarmViewModel: AlarmViewModel(), routineViewModel: RoutineViewModel())
}
