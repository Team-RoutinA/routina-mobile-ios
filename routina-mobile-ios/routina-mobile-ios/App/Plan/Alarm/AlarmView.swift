//
//  AlarmView.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/25/25.
//

import SwiftUI

struct AlarmView: View {
    @ObservedObject var alarmViewModel: AlarmViewModel
    @ObservedObject var routineViewModel: RoutineViewModel
    @State private var isPresentingCreateView = false

    private var nextAlarmText: String {
        let now = Date()

        let candidates: [Date] = alarmViewModel.alarms.compactMap { alarm in
            guard alarm.isOn else { return nil }

            let intWeekdays = alarm.weekdays.compactMap {
                AlarmViewModel.weekdayOrder.firstIndex(of: $0)
            }

            let next = AlarmViewModel.nextDate(
                hhmm: AlarmViewModel.hhmm(alarm.alarmTime),
                weekdays: intWeekdays
            )
            return next > now ? next : nil
        }

        guard let nearest = candidates.min() else { return "예정된 알람이 없어요" }

        let diff   = Int(nearest.timeIntervalSince(now))
        let days   = diff / 86_400
        let hours  = (diff % 86_400) / 3_600
        let mins   = (diff % 3_600)  / 60

        if days > 0 {
            return hours > 0 ? "\(days)일 \(hours)시간 후 울려요"
                             : "\(days)일 후 울려요"
        }
        return hours > 0 ? "\(hours)시간 \(mins)분 후 울려요"
                         : "\(mins)분 후 울려요"
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
                            timeText : alarm.timeText,
                            weekdays : alarm.orderedWeekdays,
                            routines : alarm.routines,
                            isOn     : $alarmViewModel.alarms[index].isOn,
                            onDelete : { alarmViewModel.deleteAlarm(at: index) },
                            onToggle : { newValue in
                                alarmViewModel.toggleAlarm(at: index, to: newValue)
                            }
                        )
                        .padding(.horizontal, 48)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 18)
            }
            .background(Color.gray1.ignoresSafeArea())
            .onAppear {
                routineViewModel.fetchRoutines()
                alarmViewModel.fetchAlarms()
            }
        }
        .fullScreenCover(isPresented: $isPresentingCreateView) {
            NavigationStack {
                CreateAlarmView(alarmViewModel: alarmViewModel, routineViewModel: routineViewModel)
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .alarmCreated)) { _ in
            isPresentingCreateView = false
        }
        .onAppear {
            routineViewModel.fetchRoutines()
            alarmViewModel.fetchAlarms()
        }
    }
}
