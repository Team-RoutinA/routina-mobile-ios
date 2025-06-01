//
//  RoutineControlBar.swift
//  routina-mobile-ios
//
//  Created by 이재혁 on 5/26/25.
//

import SwiftUI

struct RoutineControlBar: View {
    private var isFirst: Bool
    private var isLast: Bool
    
    init(isFirst: Bool, isLast: Bool) {
        self.isFirst = isFirst
        self.isLast = isLast
    }
    
    var body: some View {
        HStack(spacing: 0) {
            if isFirst {
                RoutineControlButton(imageName: "prev", enable: false, text: "이전") {}
                
                RoutineControlButton(imageName: "next", isPrev: false, text: "건너뛰기") {}
            } else if isLast {
                RoutineControlButton(imageName: "prev", text: "이전") {}
                
                RoutineControlButton(imageName: "next", isPrev: false, enable: false, text: "건너뛰기") {}
            } else {
                RoutineControlButton(imageName: "prev", text: "이전") {}
                
                RoutineControlButton(imageName: "next", isPrev: false, text: "건너뛰기") {}
            }
        }
    }
}

#Preview {
    RoutineControlBar(isFirst: false, isLast: false)
}
