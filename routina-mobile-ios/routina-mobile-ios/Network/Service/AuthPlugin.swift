//
//  AuthPlugin.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 6/1/25.
//

import Foundation
import Moya

final class AuthPlugin: PluginType {
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        request.addValue(userId, forHTTPHeaderField: "user-id")
        return request
    }
}
