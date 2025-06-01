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
}

extension RoutineAPI: BaseAPI {
    var path: String {
        switch self {
        case .createRoutine:
            return "/routines"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createRoutine:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .createRoutine(let request):
            return .requestJSONEncodable(request)
        }
    }
}
