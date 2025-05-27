//
//  RoutineModel.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/26/25.
//

import Foundation

struct RoutineModel: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let routineType: RoutineType? // 타입 정보 직접 저장
    let goalCount: Int? // 목표 개수 또는 지속 시간
    let limitMinutes: Int? // 마감 기한
    let successStandard: String? // 성공 기준
    
    // 기존 호환성을 위한 이니셜라이저
    init(title: String, icon: String) {
        self.title = title
        self.icon = icon
        self.routineType = nil
        self.goalCount = nil
        self.limitMinutes = nil
        self.successStandard = nil
    }
    
    // 전체 정보를 포함한 이니셜라이저
    init(title: String, icon: String, routineType: RoutineType?, goalCount: Int?, limitMinutes: Int?, successStandard: String?) {
        self.title = title
        self.icon = icon
        self.routineType = routineType
        self.goalCount = goalCount
        self.limitMinutes = limitMinutes
        self.successStandard = successStandard
    }
}
