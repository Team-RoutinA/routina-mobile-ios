//
//  AlarmModel.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/25/25.
//

import Foundation

struct AlarmItem {
    var alarmTime: Date
    //var timeText: String
    var weekdays: [String]
    var routines: [(title: String, type: String?)]
    var isOn: Bool
    
    var timeText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "a h:mm"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: alarmTime)
    }
}
