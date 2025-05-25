//
//  Base.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/25/25.
//

import Foundation

struct Base<T: Decodable>: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: T
}
