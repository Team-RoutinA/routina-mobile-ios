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
}
