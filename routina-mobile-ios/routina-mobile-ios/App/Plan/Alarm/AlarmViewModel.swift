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
    
    func addAlarm(model: AlarmModel,
                  routineIds: [String],
                  completion: @escaping (Bool) -> Void)
    {
        // 요일 문자열 → Int 배열
        let repeatDays = model.weekdays
            .compactMap { Self.weekdayOrder.firstIndex(of: $0) }
            .sorted()

        let request = AlarmCreateRequest(
            time: Self.hhmm(model.alarmTime),
            status: model.isOn ? "ON" : "OFF",
            sound_volume: model.volume,
            repeat_days: repeatDays,
            routines: routineIds.enumerated().map { idx, id in
                .init(routine_id: id, order: idx)
            }
        )
        
        service.createAlarm(request)
            .sink(receiveCompletion: { result in
                if case .failure(let err) = result {
                    print("❌ Alarm create 실패:", err)
                    completion(false)
                }
            }, receiveValue: { [weak self] response in
                var new = model
                new.alarmId = response.alarm_id
                self?.alarms.append(new)
                
                SnackBarPresenter.show(text: "알람이 성공적으로 생성되었습니다.",
                                       isSuccess: true)
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
