//
//  RoutineProceedButton.swift
//  routina-mobile-ios
//
//  Created by 이재혁 on 5/26/25.
//

import SwiftUI

struct RoutineProceedButton: View {
    
    private var text: String
    private var enable: Bool
    private var action: () -> Void
    
    init(text: String, enable: Bool, action: @escaping () -> Void) {
        self.text = text
        self.enable = enable
        self.action = action
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Button(action: action) {
                Text(text)
                    .font(.routina(.h2))
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 168, height: 49)
                    .background(RoundedRectangle(cornerRadius: 20).fill(enable ? Color.sub4Blue : Color.sub1Blue))
            }
            .disabled(!enable)
        }
        .frame(width: UIScreen.main.bounds.width)
    }
}

#Preview {
    VStack(spacing: 20) {
        RoutineProceedButton(text: "완료", enable: true) {}
        
        RoutineProceedButton(text: "이미 완료됨", enable: false) {}
    }
}
