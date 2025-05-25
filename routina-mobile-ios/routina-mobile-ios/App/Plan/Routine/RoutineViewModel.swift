//
//  RoutineViewModel.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/26/25.
//

import Foundation

final class RoutineViewModel: ObservableObject {
    @Published var routines: [RoutineItem] = []

    init() {
        // 임시 하드코딩 데이터
        loadMockData()
    }

    private func loadMockData() {
        routines = [
            RoutineItem(icon: "simple", title: "물 한 잔 마시기"),
            RoutineItem(icon: "simple", title: "오늘 일정 간단히 검토"),
            RoutineItem(icon: "time", title: "스트레칭 5분"),
            RoutineItem(icon: "numeric", title: "영어단어 10개 외우기"),
            RoutineItem(icon: "numeric", title: "푸시업 10개 하기"),
            RoutineItem(icon: "simple", title: "아침 간식 준비하기 (바나나, 요거트)"),
            RoutineItem(icon: "complex", title: "강아지 산책 갔다오기"),
            RoutineItem(icon: "simple", title: "출근 복장 최종 점검"),
            RoutineItem(icon: "time", title: "명상 10분")
        ]
    }
}
