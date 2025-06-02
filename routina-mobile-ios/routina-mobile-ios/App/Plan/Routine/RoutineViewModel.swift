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
            title: routine.title,
            type: isTimeType ? "duration" : type,
            goalValue: isTimeType ? nil : routine.goalCount,
            durationSeconds: isTimeType ? (routine.goalCount ?? 0) * 60 : nil,
            deadlineTime: String(format: "%02d:%02d", (routine.limitMinutes ?? 0) / 60, (routine.limitMinutes ?? 0) % 60),
            successNote: routine.successStandard ?? ""
        )
        .sink(receiveCompletion: { completionResult in
            if case .failure(let error) = completionResult {
                print("❌ 루틴 생성 실패: \(error)")
                completion(false)
            } else {
                print("✅ 루틴 생성 완료 - completion 정상")
            }
        }, receiveValue: { response in
            DispatchQueue.main.async {
                print("📦 루틴 추가됨: \(routine.title)")
                self.routines.append(routine)
                completion(true)
            }
        })
        .store(in: &cancellables)
    }
    
    func fetchRoutines() {
        service.fetchRoutines()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("❌ 루틴 목록 불러오기 실패: \(error)")
                }
            }, receiveValue: { responses in
                DispatchQueue.main.async {
                    // 필요한 형태로 변환
                    self.routines = responses.map { response in
                        RoutineModel(
                            title: response.title,
                            icon: response.type,
                            routineType: RoutineType(rawValue: response.type),
                            goalCount: response.goal_value,
                            limitMinutes: {
                                let parts = response.deadline_time.split(separator: ":")
                                if parts.count == 2,
                                   let hour = Int(parts[0]), let minute = Int(parts[1]) {
                                    return hour * 60 + minute
                                }
                                return nil
                            }(),
                            successStandard: response.success_note,
                            routineId: response.routine_id
                        )
                    }
                    print("✅ 루틴 목록 갱신 완료: \(self.routines.count)개")
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
