//
//  LoginAPI.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 6/1/25.
//

import Foundation
import Moya

enum LoginAPI {
    case login(email: String, password: String)
}

extension LoginAPI: BaseAPI {
    var path: String {
        switch self {
        case .login:
            return "/login"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Task {
        switch self {
        case .login(let email, let password):
            let body = LoginRequest(email: email, password: password)
            return .requestJSONEncodable(body)
        }
    }
}
