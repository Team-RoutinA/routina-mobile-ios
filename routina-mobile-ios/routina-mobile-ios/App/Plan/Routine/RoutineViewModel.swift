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
    @Published var routineStatuses: [RoutineStatus] = []
    private let service = RoutineService()
    private var cancellables = Set<AnyCancellable>()

    // 루린 생성하기
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
                print("루틴 생성 완료")
            }
        }, receiveValue: { response in
            DispatchQueue.main.async {
                print("루틴 추가됨: \(routine.title)")
                self.routines.append(routine)
                completion(true)
            }
        })
        .store(in: &cancellables)
    }
    
    // 루틴 리스트 불러오기
    func fetchRoutines(completion: (([RoutineModel]) -> Void)? = nil) {
        service.fetchRoutines()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("❌ 루틴 목록 불러오기 실패: \(error)")
                }
            }, receiveValue: { responses in
                DispatchQueue.main.async {
                    // 필요한 형태로 변환
                    self.routines = responses.map { response in
                        let backendType = response.type
                        let routineType: RoutineType? =
                            backendType == "duration" ? .time : RoutineType(rawValue: backendType)

                        // 아이콘도 동일 규칙 적용
                        let iconName = routineType?.tagImageName ?? "simple"

                        return RoutineModel(
                            title: response.title,
                            icon: iconName,
                            routineType: routineType,
                            goalCount: response.goal_value,
                            limitMinutes: {
                                let p = response.deadline_time.split(separator: ":")
                                return (p.count == 2) ? (Int(p[0])! * 60 + Int(p[1])!) : nil
                            }(),
                            successStandard: response.success_note,
                            routineId: response.routine_id
                        )
                    }
                    print("루틴 목록 갱신 완료: \(self.routines.count)개")
                    completion?(self.routines)
                }
            })
            .store(in: &cancellables)
    }
    
    // 루틴 삭제하기
    func deleteRoutine(at index: Int) {
        guard index >= 0 && index < routines.count else { return }
        
        guard let id = routines[index].routineId else {
            print("❌ 서버 routineId가 없어 삭제 불가")
            return
        }
        
        service.deleteRoutine(id: id)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("❌ 루틴 삭제 실패:", error)
                }
            }, receiveValue: { _ in
                self.routines.remove(at: index)
                print("루틴 삭제 완료")
            })
            .store(in: &cancellables)
    }

    // 루틴 수정하기
    func updateRoutine(at index: Int, with new: RoutineModel) {
        guard index < routines.count,
              let id = routines[index].routineId
        else { return }

        let isTime = new.routineType == .time

        service.updateRoutine(
            id: id,
            title: new.title,
            type: isTime ? "duration" : (new.routineType?.rawValue ?? "simple"),
            goalValue: isTime ? nil : new.goalCount,
            durationSeconds: isTime ? (new.goalCount ?? 0) * 60 : nil,
            deadlineTime: String(
                format: "%02d:%02d",
                (new.limitMinutes ?? 0) / 60,
                (new.limitMinutes ?? 0) % 60
            ),
            successNote: new.successStandard
        )
        .sink(receiveCompletion: { c in
            if case .failure(let e) = c { print("❌ 수정 실패", e) }
        }, receiveValue: { _ in
            self.routines[index] = new
            print("수정 완료")
        })
        .store(in: &cancellables)
    }
    
    // 루틴들 결과 기록
    func completeRoutines(_ routineID: String) {
        let now = ISO8601DateFormatter().string(from: Date())
        updateRoutines(id: routineID) { old in
                .init(
                    routine_id: routineID,
                    completed: true,
                    actual_value: old?.actual_value,
                    completed_ts: now,
                    abort_ts: nil
                )
        }
    }
    
    // 루틴 abort
    func abortAllRoutines(force: Bool = false) {
        let now = ISO8601DateFormatter().string(from: Date())
        routineStatuses = routineStatuses.map { routine in
            if routine.completed && !force { return routine }
            return RoutineStatus(
                routine_id: routine.routine_id,
                completed: false,
                actual_value: nil,
                completed_ts: nil,
                abort_ts: now
            )
        }
    }
    
    // 서버 보내기 위한 준비
    func updateRoutines(id: String, transform: (RoutineStatus?) -> RoutineStatus) {
        if let index = routineStatuses.firstIndex(where: { $0.routine_id == id }) {
            routineStatuses[index] = transform(routineStatuses[index])
        } else {
            routineStatuses.append(transform(nil))
        }
    }
    
    // 루틴 건너뛰기 -> 실패
    func failRoutine(_ routineID: String) {
        let now = ISO8601DateFormatter().string(from: Date())
        updateRoutines(id: routineID) { _ in
                .init(
                    routine_id: routineID,
                    completed: false,
                    actual_value: nil,
                    completed_ts: nil,
                    abort_ts: now
                )
        }
    }
    
    // 루틴결과기록 서버 보내기
    func sendRoutinesStatus(execID: String) {
        let request = RoutinesExecutionRequest(routines: routineStatuses)
        print("###################request###################\n\(request)\n\n###################request###################")
        
        let executionService = ExecutionService()
        executionService.executeRoutines(execID: execID, request: request)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("✅ 루틴 상태 업데이트 성공")
                case .failure(let error):
                    print("❌ 루틴 상태 업데이트 실패: \(error)")
                }
            }, receiveValue: { response in
                print("📦 서버 응답: \(response)")
            })
            .store(in: &cancellables)
    }
    
}
