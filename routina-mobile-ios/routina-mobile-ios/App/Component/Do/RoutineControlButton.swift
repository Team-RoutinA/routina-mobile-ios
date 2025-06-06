//
//  RoutineControlButton.swift
//  routina-mobile-ios
//
//  Created by 이재혁 on 5/26/25.
//

import SwiftUI

struct RoutineControlButton: View {
    
    private var imageName: String
    private var isPrev: Bool
    private var enable: Bool
    private var text: String
    private var action: () -> Void
    
    init(imageName: String, isPrev: Bool = true, enable: Bool = true, text: String, action: @escaping () -> Void) {
        self.imageName = imageName
        self.isPrev = isPrev
        self.enable = enable
        self.text = text
        self.action = action
    }
    
    private var buttonContent: some View {
        HStack(spacing: 8) {
            if isPrev {
                Image(imageName)
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 9.02, height: 15.16)
                    .foregroundColor(enable ? .gray6 : .gray4)
                
                Text(text)
                    .foregroundColor(enable ? .gray6 : .gray4)
                    .font(.routina(.body_sb16))
            } else {
                Text(text)
                    .foregroundColor(enable ? .gray6 : .gray4)
                    .font(.routina(.body_sb16))
                
                Image(imageName)
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 9.02, height: 15.16)
                    .foregroundColor(enable ? .gray6 : .gray4)
            }
        }
    }
    
    var body: some View {
        Button(action: action) {
            buttonContent
                .frame(width: UIScreen.main.bounds.width / 2, height: 48)
        }
        .disabled(!enable)
    }
}

#Preview {
    VStack(spacing: 30) {
        HStack(spacing: 0) {
            RoutineControlButton(imageName: "prev", text: "이전") {}
                .border(.gray)
            
            RoutineControlButton(imageName: "next", isPrev: false, text: "건너뛰기") {}
                .border(.gray)
        }
        
        HStack(spacing: 0) {
            RoutineControlButton(imageName: "prev", enable: false, text: "이전") {}
                .border(.gray)
            
            RoutineControlButton(imageName: "next", isPrev: false, enable: false, text: "건너뛰기") {}
                .border(.gray)
        }
    }
}
