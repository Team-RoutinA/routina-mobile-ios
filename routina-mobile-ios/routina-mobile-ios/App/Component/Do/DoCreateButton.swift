//
//  DoCreateButton.swift
//  routina-mobile-ios
//
//  Created by 이재혁 on 5/26/25.
//

import SwiftUI

struct DoCreateButton: View {
    
    private var imageName: String
    private var text: String
    private var action: () -> Void
    
    init(imageName: String, text: String, action: @escaping () -> Void) {
        self.imageName = imageName
        self.text = text
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 24) {
                HStack(spacing: 8) {
                    Image(imageName)
                        .resizable()
                        .frame(width: 24, height: 24)
                    
                    Text(text)
                        .font(.routina(.body_sb16))
                        .foregroundColor(.routinaBlack)
                }
                Image(systemName: "chevron.right")
                    .foregroundColor(.black)
            }
            .frame(width: UIScreen.main.bounds.width - 229, height: 68)
            .background(RoundedRectangle(cornerRadius: 12)
                .fill(.white))
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        DoCreateButton(imageName: "doCreateRoutine", text: "루틴 생성") {}
            .border(.gray)
        
        DoCreateButton(imageName: "doCreateAlarm", text: "알람 생성") {}
            .border(.gray)
    }
}
