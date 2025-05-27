//
//  AlarmModel.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/25/25.
//

import Foundation

struct AlarmModel {
    var alarmTime: Date
    var weekdays: Set<String>
    var routines: [(title: String, type: String?)]
    var isOn: Bool
    var volume: Double
    var isVibrationOn: Bool
    
    var timeText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "a h:mm"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: alarmTime)
    }
    
    // 요일을 정렬된 문자열로 반환하는 메서드 추가
    var sortedWeekdaysText: String {
        if weekdays.isEmpty {
            return "없음"
        }
        
        // 요일 순서 정의
        let weekdayOrder = ["일", "월", "화", "수", "목", "금", "토"]
        let sortedWeekdays = weekdayOrder.filter { weekdays.contains($0) }
        return sortedWeekdays.joined(separator: ", ")
    }
}
