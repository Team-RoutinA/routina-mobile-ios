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
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if isPrev {
                    if enable {
                        Image(imageName)
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 9.02, height: 15.16)
                            .foregroundColor(.gray6)
                        
                        Text(text)
                            .foregroundColor(.gray6)
                            .font(.routina(.body_sb16))
                    } else {
                        Image(imageName)
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 9.02, height: 15.16)
                            .foregroundColor(.gray4)
                        
                        Text(text)
                            .foregroundColor(.gray4)
                            .font(.routina(.body_sb16))
                    }
                } else {
                    if enable {
                        Text(text)
                            .foregroundColor(.gray6)
                            .font(.routina(.body_sb16))
                        
                        Image(imageName)
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 9.02, height: 15.16)
                            .foregroundColor(.gray6)
                    } else {
                        Text(text)
                            .foregroundColor(.gray4)
                            .font(.routina(.body_sb16))
                        
                        Image(imageName)
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 9.02, height: 15.16)
                            .foregroundColor(.gray4)

                    }
                }
            }
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
