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

    var nextAlarmText: String {
        let now = Date()
        
        // 활성화된 알람 중 미래 알람만 필터링
        let upcomingAlarms = alarmViewModel.alarms
            .filter { $0.isOn && $0.alarmTime > now }
            .sorted { $0.alarmTime < $1.alarmTime } // 가장 빠른 알람 순으로 정렬

        guard let nextAlarm = upcomingAlarms.first else {
            return "예정된 알람이 없어요"
        }

        let interval = Int(nextAlarm.alarmTime.timeIntervalSince(now))
        let hours = interval / 3600
        let minutes = (interval % 3600) / 60

        if hours > 0 {
            return "\(hours)시간 \(minutes)분 후 울려요"
        } else {
            return "\(minutes)분 후 울려요"
        }
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
