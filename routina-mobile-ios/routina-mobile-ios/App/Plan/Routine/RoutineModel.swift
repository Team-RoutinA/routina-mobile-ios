//
//  RoutineModel.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/26/25.
//

import Foundation

struct RoutineModel: Identifiable {
    let id: UUID
    let routineId: String?
    let title: String
    let icon: String
    let routineType: RoutineType?
    let goalCount: Int?
    let limitMinutes: Int?
    let successStandard: String?

    init(title: String, icon: String, routineType: RoutineType?, goalCount: Int?, limitMinutes: Int?, successStandard: String?, routineId: String? = nil) {
        self.id = UUID()
        self.routineId = routineId
        self.title = title
        self.icon = icon
        self.routineType = routineType
        self.goalCount = goalCount
        self.limitMinutes = limitMinutes
        self.successStandard = successStandard
    }
}
