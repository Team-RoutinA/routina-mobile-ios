//
//  SnackBarPresenter.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/28/25.
//

import SwiftUI

class SnackBarPresenter {
    static func show(text: String, isSuccess: Bool = true, duration: Double = 1.5) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }

        let snackBarView = UIHostingController(rootView:
            SnackBar(text: text, isSuccess: isSuccess)
                .padding(.horizontal, 24)
                .padding(.bottom, 50)
        )
        snackBarView.view.backgroundColor = .clear
        snackBarView.view.frame = CGRect(
            x: 0,
            y: window.frame.height - 120,
            width: window.frame.width,
            height: 80
        )

        window.addSubview(snackBarView.view)

        // 자동 제거
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            snackBarView.view.removeFromSuperview()
        }
    }
}
