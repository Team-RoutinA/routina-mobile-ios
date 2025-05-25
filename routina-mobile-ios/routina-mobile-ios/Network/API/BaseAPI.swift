//
//  Base.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/25/25.
//

import Foundation
import Moya

protocol BaseAPI: TargetType { }

extension BaseAPI {
    public var baseURL: URL {
        guard let baseURL = Bundle.main.infoDictionary?["API_BASE_URL"] as? String else {
            return URL(string: "dummy")!
        }
        
        return URL(string: baseURL)!
    }
    
    public var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
