//
//  RoutineViewModel.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/26/25.
//

import Foundation
import Combine

class RoutineViewModel: ObservableObject {
    @Published var routines: [RoutineModel] = []
    private let service = RoutineService()
    private var cancellables = Set<AnyCancellable>()

    func addRoutine(_ routine: RoutineModel, completion: @escaping (Bool) -> Void) {
        guard let userId = UserDefaults.standard.string(forKey: "userId") else {
            print("userId 없음")
            completion(false)
            return
        }
        
        let type = routine.routineType?.rawValue ?? "simple"
        let isTimeType = routine.routineType == .time
        
        service.createRoutine(
            userId: userId,
            title: routine.title,
            type: isTimeType ? "duration" : type,
            goalValue: isTimeType ? nil : routine.goalCount,
            durationSeconds: isTimeType ? (routine.goalCount ?? 0) * 60 : nil,
            deadlineTime: String(format: "%02d:%02d:00", (routine.limitMinutes ?? 0) / 60, (routine.limitMinutes ?? 0) % 60),
            successNote: routine.successStandard ?? ""
        )
        .sink(receiveCompletion: { completionResult in
            if case .failure(let error) = completionResult {
                print("루틴 생성 실패: \(error)")
                completion(false)
            }
        }, receiveValue: { response in
            DispatchQueue.main.async {
                self.routines.append(routine)
                completion(true)
            }
        })
        .store(in: &cancellables)
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
