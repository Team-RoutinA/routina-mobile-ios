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
    case executeRoutines(execID: String, request: RoutinesExecutionRequest)
}

extension ExecutionAPI: BaseAPI {
    var path: String {
        switch self {
        case .startAlarm:
            return "/alarm-executions"
        case .executeRoutines(let execID, _):
            return "/alarm-executions/\(execID)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .startAlarm:
            return .post
        case .executeRoutines:
            return .put
        }
    }
    
    var task: Task {
        switch self {
        case .startAlarm(let request):
            return .requestJSONEncodable(request)
        case .executeRoutines(_, let request):
            return .requestJSONEncodable(request)
        }
    }
}
