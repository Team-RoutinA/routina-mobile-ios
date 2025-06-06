//
//  ExecutionService.swift
//  routina-mobile-ios
//
//  Created by 이재혁 on 6/6/25.
//

import Foundation
import Moya
import Combine
import CombineMoya

final class ExecutionService {
    private let provider = MoyaProvider<ExecutionAPI>()
    private let decoder = JSONDecoder()
    
    // 알람 시작
    func startAlarm(_ request: StartAlarmRequest) -> AnyPublisher<StartAlarmResponse, Error> {
        
        provider.requestPublisher(.startAlarm(request: request))
            .filterSuccessfulStatusCodes()
            .map(\.data)
            .decode(type: StartAlarmResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
