//
//  Login.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 6/1/25.
//

struct LoginRequest: Encodable {
    let email: String
    let password: String
}

struct LoginResponse: Decodable {
    let user_id: String
}
