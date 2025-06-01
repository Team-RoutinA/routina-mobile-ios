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
    var baseURL: URL {
        let url = Bundle.main.infoDictionary?["API_BASE_URL"] as? String ?? "dummy"
        return URL(string: url)!
    }
    
    public var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
