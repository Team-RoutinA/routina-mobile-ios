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
    case updateRoutine(id: String, request: CreateRoutineRequest)
    case deleteRoutine(id: String) // routineId
}

extension RoutineAPI: BaseAPI {
    var path: String {
        switch self {
        case .createRoutine, .getRoutines:
            return "/routines"
        case .updateRoutine(let id, _), .deleteRoutine(let id):
            return "/routines/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createRoutine:
            return .post
        case .getRoutines:
            return .get
        case .updateRoutine:
            return .put
        case .deleteRoutine:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .createRoutine(let request), .updateRoutine(_, let request):
            return .requestJSONEncodable(request)
        case .getRoutines, .deleteRoutine:
            return .requestPlain
        }
    }
}
