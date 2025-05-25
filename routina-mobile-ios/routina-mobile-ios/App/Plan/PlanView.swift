//
//  plan.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/25/25.
//
import SwiftUI

struct PlanView: View {
    @State private var selectedTab: String = "알람"
    @State private var alarmIsOn = true

    var body: some View {
        VStack(spacing: 0) {
            TopTabBar(selectedTab: $selectedTab)
                .frame(maxWidth: .infinity)
                .background(Color.white.ignoresSafeArea(edges: .top)) // 상단에 딱 붙이기
                .zIndex(1)

            if selectedTab == "알람" {
                ScrollView {
                    AlarmCard(
                        timeText: "오전 7:20",
                        weekdays: ["월", "수", "금"],
                        routines: [
                            ("물 한 잔 마시기", "단순형"),
                            ("스트레칭 5분", "시간형"),
                            ("오늘 일정 간단히 검토", "단순형"),
                            ("아침 간식 준비 (바나나, 요거트)", "단순형"),
                            ("출근 복장 최종 점검", "단순형")
                        ],
                        isOn: $alarmIsOn,
                        onMoreTapped: {
                            print("더보기 눌림")
                        }
                    )
                    .padding()
                }
            } else {
                // 루틴 콘텐츠 자리
                ScrollView {
                    Text("루틴 목록이 여기에 들어갑니다")
                        .padding()
                }
            }
        }.background(Color.gray1)
    }
}

