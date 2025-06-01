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
        guard let urlString = Bundle.main.infoDictionary?["API_BASE_URL"] as? String,
              let url = URL(string: urlString) else {
            fatalError("API_BASE_URL is missing or invalid in Info.plist")
        }
        return url
    }

    var headers: [String: String]? {
        var header = ["Content-type": "application/json"]
        if let userId = UserDefaults.standard.string(forKey: "userId") {
            header["user-id"] = userId
        }
        return header
    }
}
