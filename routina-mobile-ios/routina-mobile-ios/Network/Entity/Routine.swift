//
//  CreateRoutine.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 6/1/25.
//

import Foundation

struct CreateRoutineRequest: Encodable {
    let title: String
    let type: String
    let goal_value: Int?
    let duration_seconds: Int?
    let deadline_time: String
    let success_note: String?
}

struct CreateRoutineResponse: Decodable {
    let user_id: String
    let title: String
    let type: String
    let goal_value: Int?
    let duration_seconds: Int?
    let deadline_time: String
    let success_note: String?
    let routine_id: String
}

struct GetRoutinesResponse: Decodable {
    let title: String
    let type: String
    let goal_value: Int?
    let duration_seconds: Int?
    let deadline_time: String
    let success_note: String?
    let routine_id: String
}

struct RoutineDetail: Decodable, Identifiable {
    let routine_id: String
    let user_id: String
    let title: String
    let type: String
    let goal_value: Int?
    let duration_seconds: Int?
    let deadline_time: String
    let success_note: String
    
    var id: String { routine_id }
}
