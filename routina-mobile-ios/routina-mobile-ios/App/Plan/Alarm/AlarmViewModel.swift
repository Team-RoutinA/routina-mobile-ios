//
//  AlarmViewModel.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/25/25.
//

import Combine
import Foundation
import SwiftUI

final class AlarmViewModel: ObservableObject {
    @Published var alarms: [AlarmModel] = []
    
    private var routineMap: [String: RoutineModel] = [:]
    
    private let service = AlarmService()
    private var bag = Set<AnyCancellable>()
    
    static let weekdayOrder = ["일","월","화","수","목","금","토"]
    
    private var toggling = Set<String>()

    // 알람 생성
    func addAlarm(model: AlarmModel,
                  completion: @escaping (Bool) -> Void) {
        
        let repeatDays = model.weekdays
            .compactMap { Self.weekdayOrder.firstIndex(of: $0) }
            .sorted()
        
        let routines = model.routines.enumerated().map { idx, item in
            CreateAlarmRequest.Routine(
                routine_id: item.id,
                order: idx + 1
            )
        }
        
        let request = CreateAlarmRequest(
            time: Self.hhmm(model.alarmTime),
            vibration_on: model.isVibrationOn,
            sound_volume: model.volume,
            status: model.isOn ? "Active" : "Inactive",
            repeat_days: repeatDays,
            routines: routines
        )
        
        service.createAlarm(request)
            .sink(receiveCompletion: { result in
                if case .failure(let err) = result {
                    print("❌ Alarm create 실패:", err)
                    completion(false)
                }
            }, receiveValue: { [weak self] response in
                var saved = model
                saved.alarmId = response.alarm_id
                self?.alarms.append(saved)
                
                SnackBarPresenter.show(
                    text: "알람이 성공적으로 생성되었습니다.",
                    isSuccess: true
                )
                completion(true)
            })
            .store(in: &bag)
    }
    
    static func hhmm(_ date: Date) -> String {
        let f = DateFormatter()
        f.dateFormat = "HH:mm"
        f.locale = Locale(identifier: "ko_KR")
        return f.string(from: date)
    }
    
    // 루틴 사전 주입
    func updateRoutineMap(_ list: [RoutineModel]) {
        routineMap = Dictionary(uniqueKeysWithValues:
            list.compactMap { r in
                guard let id = r.routineId else { return nil }
                return (id, r)
            })
    }
    
    // 알람 리스트 불러오기
    func fetchAlarms() {
        service.fetchAlarms()
            .sink(receiveCompletion: { c in
                if case .failure(let e) = c { print("❌ 알람 목록 실패:", e) }
            }, receiveValue: { [weak self] list in
                guard let self = self else { return }

                self.alarms = list.map { response in
                    let infos: [AlarmRoutineInfo] = response.routines.map { item in
                        if let r = self.routineMap[item.routine_id] {
                            return (id: item.routine_id,
                                    title: r.title,
                                    type : r.routineType?.displayName,
                                    deadline: r.limitMinutes,
                                    successStandard: r.successStandard,
                                    goalCount: r.goalCount)
                        }
                        return (id: item.routine_id, title: "(제목 없음)", type: nil, deadline: 0, successStandard: nil, goalCount: 0)
                    }

                    return AlarmModel(
                        alarmId: response.alarm_id,
                        alarmTime: Self.nextDate(hhmm: response.time,
                                                 weekdays: response.repeat_days ?? []),
                        weekdays: Set(Self.intWeekdaysToKor(response.repeat_days ?? [])),
                        routines: infos,
                        isOn: response.status == "Active",
                        volume: response.sound_volume,
                        isVibrationOn: true
                    )
                }
            })
            .store(in: &bag)
    }
    
    private static func hhmm2Date(_ hhmm: String) -> Date {
        let parts = hhmm.split(separator: ":")
        guard parts.count == 2,
              let h = Int(parts[0]),
              let m = Int(parts[1]) else { return Date() }

        var cal = Calendar.current
        cal.locale = Locale(identifier: "ko_KR")

        var comp = cal.dateComponents([.year, .month, .day], from: Date())
        comp.hour   = h
        comp.minute = m
        var date = cal.date(from: comp) ?? Date()

        // 이미 지난 시각이면 내일로 넘기기
        if date <= Date() { date = cal.date(byAdding: .day, value: 1, to: date)! }
        return date
    }
    
    private static func intWeekdaysToKor(_ nums: [Int]) -> [String] {
        let map = ["일","월","화","수","목","금","토"]
        return nums.compactMap { (0..<7).contains($0) ? map[$0] : nil }
    }
    
    static func nextDate(hhmm: String, weekdays: [Int]) -> Date {
        let comps = hhmm.split(separator: ":")
        guard comps.count == 2,
              let h = Int(comps[0]), let m = Int(comps[1]) else { return Date() }

        let cal = Calendar(identifier: .gregorian)
        let now = Date()

        if !weekdays.isEmpty {
            let candidates = weekdays.compactMap { wd -> Date? in
                var dc = DateComponents()
                dc.weekday = wd + 1
                dc.hour    = h
                dc.minute  = m
                return cal.nextDate(
                    after: now,
                    matching: dc,
                    matchingPolicy: .nextTimePreservingSmallerComponents
                )
            }
            return candidates.min() ?? now
        }

        var today = cal.date(bySettingHour: h, minute: m, second: 0, of: now)!
        if today <= now {
            today = cal.date(byAdding: .day, value: 1, to: today)!
        }
        return today
    }
    
    // 알람 삭제
    func deleteAlarm(at index: Int) {
        let targetId = alarms[index].alarmId
        service.deleteAlarm(targetId)
            .sink(receiveCompletion: { [weak self] comp in
                if case .failure(let err) = comp {
                    print("❌ Alarm delete 실패:", err)
                    SnackBarPresenter.show(text: "알람 삭제 실패", isSuccess: false)
                }
            }, receiveValue: { [weak self] in
                self?.alarms.remove(at: index)
                SnackBarPresenter.show(text: "알람이 삭제되었습니다.", isSuccess: true)
            })
            .store(in: &bag)
    }
    
    // 알람 활성화/비활성화 상태 변경
    func toggleAlarm(at index: Int, to isOn: Bool) {
        guard index < alarms.count else { return }
        
        let id = alarms[index].alarmId
        let originalState = alarms[index].isOn

        // 이미 진행 중이면 무시 (재귀 차단)
        if toggling.contains(id) {
            print("⚠️ 이미 토글 진행 중: \(id)")
            return
        }
        
        // 같은 상태면 무시
        if originalState == isOn {
            print("⚠️ 같은 상태로 토글 시도: \(originalState) -> \(isOn)")
            return
        }
        
        toggling.insert(id)

        // 즉시 UI 업데이트
        alarms[index].isOn = isOn
        
        service.updateAlarmStatus(id: id, isOn: isOn)
            .sink(receiveCompletion: { [weak self] comp in
                guard let self else { return }
                
                defer {
                    self.toggling.remove(id)
                }

                if case .failure(let error) = comp {
                    print("❌ 토글 실패: \(error)")
                    
                    if index < self.alarms.count {
                        self.alarms[index].isOn = originalState
                    }
                    
                    SnackBarPresenter.show(text: "알람 상태 변경 실패", isSuccess: false)
                } else {
                    print("토글 성공: \(id)")
                    SnackBarPresenter.show(text: "알람 상태가 변경되었습니다.", isSuccess: true)
                }
            }, receiveValue: { _ in
                // 성공 시에는 이미 UI가 업데이트되어 있음
            })
            .store(in: &bag)
    }
    
    // 활성화 & 오늘요일 & 시간서순으로 알람들 필터링
    func filteredAlarms() -> [AlarmModel] {
        let now = Date()
        let todayWeekdayIndex = Calendar.current.component(.weekday, from: now) - 1
        let todayKor = AlarmViewModel.weekdayOrder[todayWeekdayIndex]

        return alarms.filter { alarm in
            guard let alarmTime = Calendar.current.date(bySettingHour: Calendar.current.component(.hour, from: alarm.alarmTime), minute: Calendar.current.component(.minute, from: alarm.alarmTime), second: 0, of: Date()) else { return false }

            let nowTime = Calendar.current.date(bySettingHour: Calendar.current.component(.hour, from: now), minute: Calendar.current.component(.minute, from: now), second: 0, of: Date()) ?? now

            return alarm.isOn &&
                   alarm.weekdays.contains(todayKor) &&
                   alarmTime > nowTime
        }
    }
}

