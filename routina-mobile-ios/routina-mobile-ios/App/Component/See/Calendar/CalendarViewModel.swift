//
//  CalendarViewModel.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/28/25.
//

import Foundation
import Combine
import SwiftUI

class CalendarViewModel: ObservableObject {
    @Published var calendarData: [CalendarModel] = [] // 달력에 표시할 날짜별 루틴 달성률 데이터
    @Published var currentMonth: Date = Date() // 현재 보고 있는 달
    @Published var currentWeekProgress: Int = 0
    
    private let progressService = ProgressService()
    private var cancellables = Set<AnyCancellable>()

    // 생성 시 초기 데이터 로드
    init() {
        fetchCalendarData()
        fetchWeeklyFeedbackProgress(userId: "test")
    }

    // 루틴 달성률 데이터
    func fetchCalendarData() {
        let userId = "test"
        let components = Calendar.current.dateComponents([.year, .month], from: currentMonth)
        guard let year = components.year, let month = components.month else { return }

        if year == 2025 && month == 5 {
            // Insert dummy data for May 2025
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.timeZone = .current

            let dummyDates = [
                ("2025-05-01", 20),
                ("2025-05-03", 50),
                ("2025-05-07", 90),
                ("2025-05-10", 40),
                ("2025-05-15", 75),
                ("2025-05-21", 100)
            ]

            self.calendarData = dummyDates.compactMap { dateStr, progress in
                guard let date = formatter.date(from: dateStr) else { return nil }
                return CalendarModel(date: date, progress: progress)
            }
            return
        }

        // Fetch from API for other months
        progressService.fetchCalendarStats(userId: userId, year: year, month: month)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error fetching calendar stats: \(error)")
                }
            }, receiveValue: { [weak self] stats in
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                formatter.timeZone = .current
                
                self?.calendarData = stats.compactMap { item in
                    guard let date = formatter.date(from: item.date) else { return nil }
                    let progress = Int((item.success_rate * 100).rounded())
                    return CalendarModel(date: date, progress: progress)
                }
            })
            .store(in: &cancellables)
    }
    
    // 이번 주의 달성률 반환
    func fetchWeeklyFeedbackProgress(userId: String) {
        let currentWeek = Calendar.current.component(.weekOfYear, from: Date())
        print("🧭 현재 주차: \(currentWeek)")
        
        progressService.fetchWeeklyFeedback(userId: userId)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Erro fetching weekly feedback: \(error)")
                }
            }, receiveValue: { [weak self] feedbacks in
                if let thisWeek = feedbacks.first(where: { $0.week == currentWeek }) {
                    print(thisWeek.rate)
                    self?.currentWeekProgress = Int((thisWeek.rate * 100).rounded())
                }
            })
            .store(in: &cancellables)
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
