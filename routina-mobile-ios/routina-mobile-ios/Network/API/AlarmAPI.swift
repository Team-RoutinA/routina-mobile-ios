//
//  AlarmAPI.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 6/2/25.
//

import Foundation
import Moya

enum AlarmAPI {
    case createAlarm(request: CreateAlarmRequest)
    case getAlarms
    case deleteAlarm(id: String) // alarmId
    case updateAlarmStatus(id: String, status: String) // alarmId
    case getAlarm(id: String) // 특정 알람 조회
}

extension AlarmAPI: BaseAPI {
    var path: String {
        switch self {
        case .createAlarm, .getAlarms:
            return "/alarms"
        case .deleteAlarm(let id), .updateAlarmStatus(let id, _):
            return "/alarms/\(id)"
        case .getAlarm(let id):
            return "/alarms/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createAlarm:
            return .post
        case .getAlarms, .getAlarm:
            return .get
        case .deleteAlarm:
            return .delete
        case .updateAlarmStatus:
            return .patch
        }
    }
    
    var task: Task {
        switch self {
        case .createAlarm(let request):
            return .requestJSONEncodable(request)
        case .getAlarms, .deleteAlarm, .getAlarm:
            return .requestPlain
        case .updateAlarmStatus(_, let status):
            return .requestParameters(
                parameters: ["status": status],
                encoding: URLEncoding.queryString
            )
        }
    }
}
