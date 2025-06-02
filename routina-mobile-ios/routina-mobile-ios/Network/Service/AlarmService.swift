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

    /// 알람 생성
    func createAlarm(_ req: AlarmCreateRequest)
        -> AnyPublisher<AlarmCreateResponse, Error> {

        provider.requestPublisher(.createAlarm(request: req))
            .filterSuccessfulStatusCodes()
            .map(\.data)
            .decode(type: AlarmCreateResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
