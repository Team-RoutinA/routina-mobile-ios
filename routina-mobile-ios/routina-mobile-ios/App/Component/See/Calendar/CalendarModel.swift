//
//  CalendarModel.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/28/25.
//

import Foundation

struct CalendarModel: Identifiable {
    let id = UUID()
    let date: Date
    let progress: Int // 루틴 달성률 (0~100)
}
