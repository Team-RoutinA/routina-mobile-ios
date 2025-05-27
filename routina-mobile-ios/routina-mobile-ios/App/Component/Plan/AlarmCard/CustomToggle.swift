//
//  Toggle.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/25/25.
//

import SwiftUI

/// 메인 블루 색상과 그레이 색상을 사용하는 커스텀 토글 스타일
/// 기본 토글보다 크기 조절과 색상 변경이 자유롭다
struct CustomToggle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            // Toggle의 label은 사용하지 않으므로 생략
            configuration.label

            ZStack {
                // 배경 Capsule: 켜짐/꺼짐 상태에 따라 색상 변경
                Capsule()
                    .fill(configuration.isOn ? Color.mainBlue : Color.gray3)
                    .frame(width: 48, height: 24) // 토글 전체 크기 설정

                // 안의 원 Circle: 토글 핸들
                Circle()
                    .fill(Color.white)
                    .frame(width: 22, height: 22) // 토글 핸들 크기
                    .offset(x: configuration.isOn ? 11 : -11) // 위치 이동
                    .animation(.easeInOut(duration: 0.2), value: configuration.isOn) // 부드러운 슬라이드 애니메이션
            }
            .onTapGesture {
                // 탭 시 토글 상태 전환
                configuration.isOn.toggle()
            }
        }
    }
}
