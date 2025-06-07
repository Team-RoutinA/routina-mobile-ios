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

struct RoutinesExecutionRequest: Encodable {
    let routines: [RoutineStatus]
}

struct RoutineStatus: Encodable {
    let routine_id: String
    let completed: Bool
    let actual_value: Int?
    let completed_ts: String?
    let abort_ts: String?
}

struct RoutinesExecutionResponse: Decodable {
    let exec_id: String
    let alarm_id: String
    let status: String
    let total_routines: Int
    let completed_routines: Int
    let success_rate: Double
    let routine_execution_details: [RoutineExecutionDetail]
}

struct RoutineExecutionDetail: Decodable {
    let routine_id: String
    let actual_value: Int?
    let exec_id: String
    let abort_ts: String?
    let completed: Int
    let axr_id: String
    let completed_ts: String?
    let order: Int
}
