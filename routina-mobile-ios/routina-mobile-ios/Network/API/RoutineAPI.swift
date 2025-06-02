//
//  RoutineAPI.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 6/1/25.
//

import Foundation
import Moya

enum RoutineAPI {
    case createRoutine(request: CreateRoutineRequest)
    case getRoutines
}

extension RoutineAPI: BaseAPI {
    var path: String {
        switch self {
        case .createRoutine, .getRoutines:
            return "/routines"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createRoutine:
            return .post
        case .getRoutines:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .createRoutine(let request):
            return .requestJSONEncodable(request)
        case .getRoutines:
            return .requestPlain
        }
    }
}
