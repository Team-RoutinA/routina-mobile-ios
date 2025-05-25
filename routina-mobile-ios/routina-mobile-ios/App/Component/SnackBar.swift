//
//  SnackBar.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/25/25.
//

import SwiftUI

struct SnackBar: View {
    
    private var text: String
    private var isSuccess: Bool
    
    init(
        text: String,
        isSuccess: Bool = true
    ) {
        self.text = text
        self.isSuccess = isSuccess
    }
    
    var body: some View {
        HStack(spacing: 10) {
            Image(isSuccess ? "success" : "fail")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(isSuccess ? .green : .red)
            Text(text)
                .font(.routina(.body_m14))
                .foregroundColor(.white)
            Spacer()
        }
        .padding(.horizontal, 24)
        .frame(width: UIScreen.main.bounds.width - 48, height: 48)
        .background(Color.black)
        .cornerRadius(14)
    }
}

#Preview {
    VStack(spacing: 30) {
        SnackBar(text: "알람이 성공적으로 생성되었습니다.", isSuccess: true)
        SnackBar(text: "알람 생성에 실패하였습니다.", isSuccess: false)
    }
    .padding(.horizontal)
}
