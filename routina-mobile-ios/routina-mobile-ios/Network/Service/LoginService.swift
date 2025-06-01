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
    
    func login(email: String, password: String) -> AnyPublisher<LoginResponse, Error> {
        return provider.requestPublisher(.login(email: email, password: password))
            .tryMap { response in
                guard (200..<300).contains(response.statusCode) else {
                    throw MoyaError.statusCode(response)
                }
                return response.data
            }
            .decode(type: LoginResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
