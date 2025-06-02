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
    
    private let service = AlarmService()
    private var bag = Set<AnyCancellable>()
    
    private static let weekdayOrder = ["일","월","화","수","목","금","토"]

    // 루틴 생성
    func addAlarm(model: AlarmModel,
                  completion: @escaping (Bool) -> Void) {
        
        let repeatDays = model.weekdays
            .compactMap { Self.weekdayOrder.firstIndex(of: $0) }
            .sorted()
        
        let routines = model.routines.enumerated().map { idx, item in
            AlarmCreateRequest.Routine(
                routine_id: item.id,
                order: idx + 1
            )
        }
        
        let request = AlarmCreateRequest(
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
    
    private static func hhmm(_ date: Date) -> String {
        let f = DateFormatter()
        f.dateFormat = "HH:mm"
        f.locale = Locale(identifier: "ko_KR")
        return f.string(from: date)
    }
}
