//
//  LoginViewModel.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 6/1/25.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var loginError: String?
    @Published var isLoggedIn: Bool = false

    private var cancellables = Set<AnyCancellable>()
    private let service = LoginService()

    func login() {
        service.login(email: email, password: password)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.loginError = "로그인 실패: \(error.localizedDescription)"
                }
            }, receiveValue: { userId in
                print("로그인 성공 user_id: \(userId)")
                UserDefaults.standard.set(userId, forKey: "userId")
                self.isLoggedIn = true
            })
            .store(in: &cancellables)
    }
}
