//
//  LoginService.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 6/1/25.
//

import Foundation
import Moya
import Combine
import CombineMoya

class LoginService {
    private let provider = MoyaProvider<LoginAPI>()
    
    func login(email: String, password: String) -> AnyPublisher<String, Error> {
        provider.requestPublisher(.login(email: email, password: password))
            .tryMap { response in
                guard (200..<300).contains(response.statusCode) else {
                    throw MoyaError.statusCode(response)
                }

                guard let userIdString = String(data: response.data, encoding: .utf8) else {
                    throw URLError(.cannotParseResponse)
                }

                // JSONDecoder는 따옴표 없는 문자열을 못 읽음 → 따옴표 제거
                let cleaned = userIdString.trimmingCharacters(in: .init(charactersIn: "\""))
                return cleaned
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
