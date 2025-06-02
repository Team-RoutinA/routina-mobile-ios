//
//  AlarmService.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 6/2/25.
//

import Foundation
import Moya
import Combine
import CombineMoya

final class AlarmService {
    private let provider = MoyaProvider<AlarmAPI>()
    private let decoder  = JSONDecoder()
    
    // 알람 생성
    func createAlarm(_ request: CreateAlarmRequest)
    -> AnyPublisher<CreateAlarmResponse, Error> {
        
        provider.requestPublisher(.createAlarm(request: request))
            .filterSuccessfulStatusCodes()
            .map(\.data)
            .decode(type: CreateAlarmResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    // 알람 조회
    func fetchAlarms()
    -> AnyPublisher<[GetAlarmResponse], Error> {
        
        provider.requestPublisher(.getAlarms)
            .filterSuccessfulStatusCodes()
            .map(\.data)
            .decode(type: [GetAlarmResponse].self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    // 알람 삭제
    func deleteAlarm(_ id: String) -> AnyPublisher<Void, Error> {
        provider.requestPublisher(.deleteAlarm(id: id))
            .filterSuccessfulStatusCodes()
            .map { _ in () }
            .mapError { $0 as Error }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    // 알람 활성화/비활성화 상태 업데이트
    func updateAlarmStatus(id: String, isOn: Bool) -> AnyPublisher<Void, Error> {
        let newStatus = isOn ? "Active" : "Inactive"
        return provider.requestPublisher(.updateAlarmStatus(id: id, status: newStatus))
            .filterSuccessfulStatusCodes()
            .map { _ in () }
            .mapError { $0 as Error }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
