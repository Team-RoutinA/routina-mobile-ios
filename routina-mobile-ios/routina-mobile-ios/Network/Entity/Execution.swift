//
//  Execution.swift
//  routina-mobile-ios
//
//  Created by 이재혁 on 6/6/25.
//

import Foundation

struct StartAlarmRequest: Encodable {
    let alarm_id: String
    let scheduled_ts: String
    let dismissed_ts: String
    let routines: [ExecutionRoutine]
}

struct ExecutionRoutine: Codable {
    let routine_id: String
    let completed: Bool
    let actual_value: Int?
    let completed_ts: Date?
    let abort_ts: Date?
    let order: Int
}

struct StartAlarmResponse: Decodable {
    let message: String
    let exec_id: String
}
