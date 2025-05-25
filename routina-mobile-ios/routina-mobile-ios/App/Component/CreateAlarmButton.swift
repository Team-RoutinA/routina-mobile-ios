//
//  CreateAlarmButton.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/25/25.
//

import SwiftUI

struct CreateAlarmButton: View {
    
    private var text: String
    private var action: () -> Void
    
    init(
        text: String,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.action = action
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Button(action: action) {
                Text(text)
                    .font(.routina(.caption1))
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.width - 48, height: 36)
                    .background(RoundedRectangle(cornerRadius: 16).fill(.white))
            }
        }
        .frame(width: UIScreen.main.bounds.width)
    }
}

#Preview {
    VStack(spacing: 30) {
        CreateAlarmButton(text: "+ 알람 생성하기") {}
            .border(.gray)
    }
    .padding(.horizontal)
}
