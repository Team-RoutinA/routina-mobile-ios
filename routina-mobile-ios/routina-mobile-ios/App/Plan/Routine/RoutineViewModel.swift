//
//  RoutineViewModel.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/26/25.
//

import Foundation

class RoutineViewModel: ObservableObject {
    @Published var routines: [RoutineModel] = [
        RoutineModel(title: "물 한 잔 마시기", icon: "simple"),
        RoutineModel(title: "스트레칭 5분", icon: "time")
    ]

    func addRoutine(_ routine: RoutineModel) {
        routines.append(routine)
    }
}
