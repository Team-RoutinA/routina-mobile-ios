//
//  WelcomeBox.swift
//  routina-mobile-ios
//
//  Created by 이재혁 on 5/26/25.
//

import SwiftUI

struct WelcomeBox: View {
    
    private var name: String
    private var action: () -> Void
    
    init(name: String, action: @escaping () -> Void) {
        self.name = name
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(.welcomeSun)
                    .resizable()
                    .frame(width: 48, height: 48)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(name) 님, 좋은 아침이에요.")
                        .font(.routina(.body_sb16))
                        .foregroundColor(.black)
                    
                    Text("루틴 리포트 바로가기 >")
                        .font(.routina(.caption2))
                        .foregroundColor(.black)
                }
                .padding(.trailing, 102)
            }
            .frame(width: UIScreen.main.bounds.width - 48, height: 82)
            .background(RoundedRectangle(cornerRadius: 12).fill(.white))
        }
    }
}

#Preview {
    WelcomeBox(name: "박상혁") {}
        .border(.gray)
}
