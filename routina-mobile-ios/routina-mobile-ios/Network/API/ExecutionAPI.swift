//
//  ExecutionAPI.swift
//  routina-mobile-ios
//
//  Created by 이재혁 on 6/6/25.
//

import Foundation
import Moya

enum ExecutionAPI {
    case startAlarm(request: StartAlarmRequest)
}

extension ExecutionAPI: BaseAPI {
    var path: String {
        switch self {
        case .startAlarm:
            return "/alarm-executions"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .startAlarm:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .startAlarm(let request):
            return .requestJSONEncodable(request)
        }
    }
}
