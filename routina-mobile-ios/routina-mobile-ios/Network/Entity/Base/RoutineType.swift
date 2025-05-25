//
//  RoutineType.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/25/25.
//

import Foundation

enum RoutineType: String, Codable {
    case numeric
    case time
    case simple
    case complex

    var tagImageName: String {
        switch self {
        case .numeric: return "tag_numeric"
        case .time: return "tag_time"
        case .simple: return "tag_simple"
        case .complex: return "tag_complex"
        }
    }

    var displayName: String {
        switch self {
        case .numeric: return "정량형"
        case .time: return "시간형"
        case .simple: return "단순형"
        case .complex: return "복합형"
        }
    }
}
