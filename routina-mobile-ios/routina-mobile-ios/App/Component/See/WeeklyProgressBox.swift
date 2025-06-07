//
//  WeeklyProgressBox.swift
//  routina-mobile-ios
//
//  Created by 이재혁 on 6/7/25.
//

import SwiftUI

struct WeeklyProgressBox: View {
    private var progress: Int
    
    init(progress: Int) {
        self.progress = progress
    }
    
    var body: some View {
        Group {
            HStack(spacing: 12) {
                Image(.progressHeart)
                    .resizable()
                    .frame(width: 36, height: 36)
                Spacer().frame(width: 1)
                VStack(alignment: .leading, spacing: 4) {
                    Text("이번 주 루틴을 평균 \(progress)% 달성하셨네요!")
                        .font(.routina(.body_m14))
                        .foregroundColor(.black)
                        .lineLimit(1)
                    
                    Text("조금만 더 힘내면 완벽한 한 주를 만들 수 있어요!")
                        .font(.routina(.caption3))
                        .foregroundColor(.black)
                }
            }
            .frame(width: 345, height: 80)
            .background(RoundedRectangle(cornerRadius: 12).fill(.gray1))
        }
    }
}

#Preview {
    WeeklyProgressBox(progress: 99)
}
