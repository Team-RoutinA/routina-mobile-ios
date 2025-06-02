//
//  AlarmAPI.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 6/2/25.
//

import Foundation
import Moya

enum AlarmAPI {
    case createAlarm(request: AlarmCreateRequest)
}

extension AlarmAPI: BaseAPI {
    var path: String {
        switch self {
        case .createAlarm:
            return "/alarms"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createAlarm:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .createAlarm(let request):
            return .requestJSONEncodable(request)
        }
    }
}
