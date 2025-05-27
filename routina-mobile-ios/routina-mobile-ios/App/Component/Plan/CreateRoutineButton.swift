//
//  CreateRoutineButton.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/26/25.
//

import SwiftUI

struct CreateRoutineButton: View {
    var text: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image("plusR")
                    .resizable()
                    .frame(width: 36, height: 36)

                Text(text)
                    .font(.routina(.body_m16))
                    .foregroundColor(.gray4)

                Spacer()
            }
            .padding(.horizontal, 20)
            .frame(height: 56)
            .background(Color.white)
            .cornerRadius(20)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    CreateRoutineButton(text: "루틴 생성하기") {
        print("루틴 생성")
    }
    .padding()
    .background(Color.gray1)
}
