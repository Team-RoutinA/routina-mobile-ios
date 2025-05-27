//
//  AlarmViewModel.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/25/25.
//

import SwiftUI

class AlarmViewModel: ObservableObject {
    @Published var alarms: [AlarmModel] = [
        AlarmModel(
            alarmTime: AlarmViewModel.makeDate(hour: 7, minute: 20),
            weekdays: Set(["월", "수", "금"]),
            routines: [
                ("물 한 잔 마시기", "단순형"),
                ("스트레칭 5분", "시간형"),
                ("오늘 일정 간단히 검토", "단순형"),
                ("아침 간식 준비 (바나나, 요거트)", "단순형"),
                ("출근 복장 최종 점검", "단순형")
            ],
            isOn: true,
            volume: 0.3,
            isVibrationOn: true
        ),
        AlarmModel(
            alarmTime: AlarmViewModel.makeDate(hour: 6, minute: 20),
            weekdays: Set(["화", "목"]),
            routines: [
                ("5분 동안 스트레칭", "시간형")
            ],
            isOn: false,
            volume: 0.7,
            isVibrationOn: false
        )
    ]
    
    /// 오늘 날짜 기준으로 특정 시각의 Date 객체 생성
    private static func makeDate(hour: Int, minute: Int) -> Date {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ko_KR")
        var components = calendar.dateComponents([.year, .month, .day], from: Date())
        components.hour = hour
        components.minute = minute
        return calendar.date(from: components) ?? Date()
    }
}

