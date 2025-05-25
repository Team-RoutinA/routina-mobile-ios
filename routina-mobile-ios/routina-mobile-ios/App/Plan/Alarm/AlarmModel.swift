//
//  AlarmModel.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/25/25.
//

import Foundation

struct AlarmItem {
    var timeText: String
    var weekdays: [String]
    var routines: [(title: String, type: String?)]
    var isOn: Bool
}
