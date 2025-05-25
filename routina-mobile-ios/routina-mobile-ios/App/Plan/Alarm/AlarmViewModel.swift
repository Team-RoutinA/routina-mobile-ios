//
//  AlarmViewModel.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/25/25.
//

import SwiftUI

class AlarmViewModel: ObservableObject {
    @Published var alarms: [AlarmItem] = [
        AlarmItem(
            timeText: "오전 7:20",
            weekdays: ["월", "수", "금"],
            routines: [
                ("물 한 잔 마시기", "단순형"),
                ("스트레칭 5분", "시간형"),
                ("오늘 일정 간단히 검토", "단순형"),
                ("아침 간식 준비 (바나나, 요거트)", "단순형"),
                ("출근 복장 최종 점검", "단순형")
            ],
            isOn: true
        ),
        AlarmItem(
            timeText: "오전 6:20",
            weekdays: ["화", "목"],
            routines: [
                ("5분 동안 스트레칭", "시간형"),
            ],
            isOn: false
        )
    ]
}
