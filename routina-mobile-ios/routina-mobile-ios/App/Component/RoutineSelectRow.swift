//
//  RoutineSelectRow.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/25/25.
//

import SwiftUI

struct RoutineSelectRow: View {
    let iconName: String // 아이콘 이미지 이름
    let title: String  // 루틴 제목 (예: "영어단어 10개 외우기")
    let subtitle: String? // 부가 설명 (예: "기상 후 30분")
    let showChevron: Bool // > 화살표 표시 여부
    let isPlaceholder: Bool // 회색 안내 문구인지 여부
    let onTap: () -> Void  // 탭 시 실행되는 액션

    var body: some View {
        Button(action: onTap) {
            HStack {
                if isPlaceholder {
                    HStack {
                        Spacer()
                        Text(title)
                            .font(.routina(.body_r16))
                            .foregroundColor(.gray4)
                        Spacer()
                    }
                } else {
                    HStack(spacing: 12) {
                        Image(iconName)
                            .resizable()
                            .frame(width: 36, height: 36)

                        Text(title)
                            .font(.routina(.body_sb16))
                            .foregroundColor(.black)
                    }

                    Spacer()

                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(.routina(.caption1))
                            .foregroundColor(.gray6)
                    }

                    if showChevron {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray4)
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 6)
            .background(Color.white)
            //.cornerRadius(12)
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        RoutineSelectRow(
            iconName: "numeric",
            title: "영어단어 10개 외우기",
            subtitle: "기상 후 30분",
            showChevron: false,
            isPlaceholder: false,
            onTap: { print("선택됨") }
        )

        RoutineSelectRow(
            iconName: "",
            title: "아래에서 루틴을 선택해 주세요",
            subtitle: nil,
            showChevron: false,
            isPlaceholder: true,
            onTap: { print("플레이스홀더 탭됨") }
        )

        RoutineSelectRow(
            iconName: "numeric",
            title: "영어단어 10개 외우기",
            subtitle: nil,
            showChevron: true,
            isPlaceholder: false,
            onTap: { print("편집용 탭") }
        )
    }
    .padding(.vertical, 16)
    .background(Color.gray1)
}
