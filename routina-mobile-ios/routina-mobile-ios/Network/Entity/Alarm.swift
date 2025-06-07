//
//  Alarm.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 6/2/25.
//

import Foundation

struct CreateAlarmRequest: Encodable {
    let time: String
    let vibration_on: Bool
    let sound_volume: Double
    let status: String
    let repeat_days: [Int]?
    struct Routine: Codable {
        let routine_id: String
        let order: Int
    }
    let routines: [Routine]
}

struct CreateAlarmResponse: Decodable {
    let alarm_id: String
    let time: String
    let status: String
    let sound_volume: Double
    let repeat_days: [Int]?
    let routines: [CreateAlarmRequest.Routine]
}

struct GetAlarmResponse: Decodable {
    let alarm_id: String
    let time: String
    let status: String
    let sound_volume: Double
    let repeat_days: [Int]?
    let routines: [CreateAlarmRequest.Routine]
}

struct GetAlarmDetailResponse: Decodable {
    let alarm_id: String
    let user_id: String?
    let time: String
    let vibration_on: Bool
    let sound_volume: Double
    let status: String
    let repeat_days: [Int]?
    let routines: [RoutineDetail]
}
