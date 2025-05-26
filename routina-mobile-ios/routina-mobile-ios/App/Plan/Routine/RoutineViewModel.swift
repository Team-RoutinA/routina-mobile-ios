//
//  RoutineViewModel.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/26/25.
//

import Foundation

class RoutineViewModel: ObservableObject {
    @Published var routines: [RoutineModel] = [
        RoutineModel(title: "물 한 잔 마시기", icon: "simple", routineType: .simple, goalCount: nil, limitMinutes: 30, successStandard: "하루에 8잔 마시기"),
        RoutineModel(title: "스트레칭 5분", icon: "time", routineType: .time, goalCount: 5, limitMinutes: 60, successStandard: "목과 어깨 위주로")
    ]

    func addRoutine(_ routine: RoutineModel) {
        routines.append(routine)
    }
    
    func updateRoutine(at index: Int, with routine: RoutineModel) {
        guard index >= 0 && index < routines.count else { return }
        routines[index] = routine
    }
    
    func deleteRoutine(at index: Int) {
        guard index >= 0 && index < routines.count else { return }
        routines.remove(at: index)
    }
}
