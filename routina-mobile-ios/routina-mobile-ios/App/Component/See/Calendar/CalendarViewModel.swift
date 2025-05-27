//
//  CalendarViewModel.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/28/25.
//

import Foundation
import Combine

class CalendarViewModel: ObservableObject {
    @Published var calendarData: [CalendarModel] = [] // 달력에 표시할 날짜별 루틴 달성률 데이터
    @Published var currentMonth: Date = Date() // 현재 보고 있는 달

    // 생성 시 초기 데이터 로드
    init() {
        fetchCalendarData()
    }

    // 임의의 루틴 달성률 데이터 생성
    func fetchCalendarData() {
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone.current

        calendarData = []

        // 5월 1일부터 20일까지 생성
        for day in 1...20 {
            if let date = formatter.date(from: "2025-05-\(String(format: "%02d", day))") {
                let progress = Int.random(in: 40...100) // 적당한 임의의 달성률
                calendarData.append(CalendarModel(date: date, progress: progress))
            }
        }

        // currentMonth 5월로 강제 설정
        if let may1st = formatter.date(from: "2025-05-01") {
            currentMonth = may1st
        }
    }

    // 특정 날짜에 해당하는 루틴 달성률 반환
    func progress(for date: Date) -> Int? {
        calendarData.first { Calendar.current.isDate($0.date, inSameDayAs: date) }?.progress
    }

    // 주어진 날짜가 현재 보고 있는 달에 포함되는지 여부 반환
    func isDateInCurrentMonth(_ date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.component(.year, from: date) == calendar.component(.year, from: self.currentMonth) &&
               calendar.component(.month, from: date) == calendar.component(.month, from: self.currentMonth)
    }
}
