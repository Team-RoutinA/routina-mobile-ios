//
//  ProgressAPI.swift
//  routina-mobile-ios
//
//  Created by 이재혁 on 6/7/25.
//

import Foundation
import Moya

enum ProgressAPI {
    case getCalendar(userId: String, year: Int, month: Int)
}

extension ProgressAPI: BaseAPI {
    var path: String {
        switch self {
        case .getCalendar:
            return "/calendar"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCalendar:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getCalendar(let userId, let year, let month):
            return .requestParameters(
                parameters: ["user_id": userId, "year": year, "month": month],
                encoding: URLEncoding.queryString
            )
        }
    }
}
