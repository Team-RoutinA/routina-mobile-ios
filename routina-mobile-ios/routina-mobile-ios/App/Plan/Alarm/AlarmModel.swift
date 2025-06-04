//
//  AlarmModel.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/25/25.
//

import Foundation

struct AlarmModel {
    var alarmId: String = ""
    var alarmTime: Date
    var weekdays: Set<String>
    var routines: [AlarmRoutineInfo]
    var isOn: Bool
    var volume: Double
    var isVibrationOn: Bool
    
    var timeText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "a h:mm"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: alarmTime)
    }
}

extension AlarmModel {
    // 월 → 일 순서로 정렬된 요일 배열
    var orderedWeekdays: [String] {
        let order = ["월","화","수","목","금","토","일"]
        return order.filter { weekdays.contains($0) }
    }
}
