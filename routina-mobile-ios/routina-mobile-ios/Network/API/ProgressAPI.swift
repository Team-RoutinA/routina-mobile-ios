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
    case getWeeklyFeedback(userId: String)
}

extension ProgressAPI: BaseAPI {
    var path: String {
        switch self {
        case .getCalendar:
            return "/calendar"
        case .getWeeklyFeedback:
            return "/weekly-feedback"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCalendar, .getWeeklyFeedback:
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
        case .getWeeklyFeedback(let userId):
            return .requestParameters(
                parameters: ["user_id": userId],
                encoding: URLEncoding.queryString
            )
        }
    }
}
