//
//  Progress.swift
//  routina-mobile-ios
//
//  Created by 이재혁 on 6/7/25.
//

import Foundation

struct CalendarSuccessRate: Decodable {
    let date: String
    let success_rate: Double
}

struct WeeklyFeedback: Decodable {
    let week: Int
    let done: Int
    let completed: Int
    let rate: Double
}
