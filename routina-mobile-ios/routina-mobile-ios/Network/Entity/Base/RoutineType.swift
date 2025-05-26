//
//  RoutineType.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/25/25.
//

import Foundation

enum RoutineType: String, Codable, CaseIterable {
    case numeric
    case time
    case simple
    case complex

    var tagImageName: String {
        switch self {
        case .numeric: return "numeric"
        case .time: return "time"
        case .simple: return "simple"
        case .complex: return "complex"
        }
    }
    
    var tagIconName: String {
        switch self {
        case .numeric: return "numericIcon"
        case .time: return "timeIcon"
        case .simple: return "simpleIcon"
        case .complex: return "complexIcon"
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
    
    var description: String {
        switch self {
        case .numeric: return "완료 여부와 더불어 수행 개수를 확인할 수 있는 루틴 유형입니다. \n정해진 목표 개수가 있는 경우 개수형 루틴을 권장합니다."
        case .time: return "10분 명상, 5분 스트레칭과 같이 목표 시간이 존재하는 경우 시간형 루틴을 권장합니다."
        case .simple: return "완료 여부만 확인할 수 있는 간단한 루틴 유형입니다."
        case .complex: return "단순형 루틴과 비슷하지만, 마감 기간을 더 길게 설정할 수 있습니다. “강아지 산책”과 같이 수행하는 데 오래 걸리는 경우 복합형 루틴을 권장합니다."
        }
    }

}
