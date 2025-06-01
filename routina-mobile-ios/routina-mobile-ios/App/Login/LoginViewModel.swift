//
//  LoginViewModel.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 6/1/25.
//

// LoginViewModel.swift

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
            }, receiveValue: { response in
                // 🔍 여기서 실제로 뭐가 오는지 확인
                print("📥 로그인 응답: \(response)")
                print("📥 받은 user_id: \(response.user_id)")
                
                // UserDefaults에 저장
                UserDefaults.standard.set(response.user_id, forKey: "userId")
                
                // 🔍 제대로 저장되었는지 확인
                let saved = UserDefaults.standard.string(forKey: "userId")
                print("💾 저장된 user_id: \(saved ?? "저장 실패")")
                
                self.isLoggedIn = true
            })
            .store(in: &cancellables)
    }
}

