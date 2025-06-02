//
//  Alarm.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 6/2/25.
//

import Foundation

struct AlarmCreateRequest: Encodable {
    let time: String
    let status: String
    let sound_volume: Double
    let repeat_days: [Int]?
    struct Routine: Codable {
        let routine_id: String
        let order: Int
    }
    let routines: [Routine]
}

struct AlarmCreateResponse: Decodable {
    let alarm_id: String
    let time: String
    let status: String
    let sound_volume: Double
    let repeat_days: [Int]?
    let routines: [AlarmCreateRequest.Routine]
}
