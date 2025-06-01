//
//  RoutineAPI.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 6/1/25.
//

import Foundation
import Moya

enum RoutineAPI {
    case createRoutine(userId: String, request: CreateRoutineRequest)
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
        case .createRoutine(let userId, let request):
            return .requestCompositeParameters(
                bodyParameters: request.toDictionary(),
                bodyEncoding: JSONEncoding.default,
                urlParameters: ["user_id": userId]
            )
        }
    }
}

extension Encodable {
    func toDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        return (try? JSONSerialization.jsonObject(with: data)) as? [String: Any] ?? [:]
    }
}
