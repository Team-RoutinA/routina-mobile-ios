//
//  LoginView.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 6/1/25.
//

import SwiftUI

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack {
                // 상단 타이틀
                VStack(alignment: .leading, spacing: 8) {
                    Text("당신만의 루틴 관리 에이전트,")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.black)
                    Text("로그인하고 지금 바로 시작하세요.")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 44)
                .padding(.top, 80)

                Spacer()

                // 중앙 텍스트필드
                VStack(spacing: 16) {
                    TextField("이메일 주소", text: $viewModel.email)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(16)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)

                    SecureField("비밀번호", text: $viewModel.password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(16)
                }
                .padding(.horizontal, 44)
                .padding(.top, -20)

                Spacer()

                // 하단 고정 로그인 버튼
                VStack(spacing: 12) {
                    if let error = viewModel.loginError {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.system(size: 14))
                    }

                    MainButton(
                        text: "로그인",
                        enable: !viewModel.email.isEmpty && !viewModel.password.isEmpty
                    ) {
                        viewModel.login()
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 32)
            }
        }
        .onChange(of: viewModel.isLoggedIn) { newValue in
            if newValue {
                isLoggedIn = true
            }
        }
    }
}
