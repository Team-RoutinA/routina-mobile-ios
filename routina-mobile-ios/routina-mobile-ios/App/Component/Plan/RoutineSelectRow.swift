//
//  RoutineSelectRow.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/25/25.
//

import SwiftUI

struct RoutineSelectRow: View {
    let iconName: String
    let title: String
    let subtitle: String?
    let showChevron: Bool
    let isPlaceholder: Bool
    let onTap: () -> Void

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
            .padding(.vertical, 6)
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
