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
                                    type : r.routineType?.displayName)
                        }
                        return (id: item.routine_id, title: "(제목 없음)", type: nil)
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
}

