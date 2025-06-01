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
        VStack(spacing: 32) {
            Spacer()

            VStack(alignment: .leading, spacing: 8) {
                Text("당신만의 루틴 관리 에이전트,")
                    .font(.title)
                    .fontWeight(.bold)
                Text("로그인하고 지금 바로 시작하세요.")
                    .font(.body)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)

            VStack(spacing: 16) {
                TextField("이메일 주소", text: $viewModel.email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(16)

                SecureField("비밀번호", text: $viewModel.password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(16)
            }
            .padding(.horizontal)

            Spacer()

            Button(action: {
                viewModel.login()
            }) {
                Text("로그인")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(20)
            }
            .padding(.horizontal)
            .padding(.bottom, 20)

            if let error = viewModel.loginError {
                Text(error)
                    .foregroundColor(.red)
            }
        }
        .ignoresSafeArea(.keyboard)
        .onChange(of: viewModel.isLoggedIn) { newValue in
            if newValue {
                isLoggedIn = true
            }
        }
    }
}
