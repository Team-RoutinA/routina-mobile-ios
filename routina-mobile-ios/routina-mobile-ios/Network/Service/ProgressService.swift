//
//  ProgressService.swift
//  routina-mobile-ios
//
//  Created by 이재혁 on 6/7/25.
//

import Foundation
import Moya
import Combine
import CombineMoya

final class ProgressService {
    private let provider = MoyaProvider<ProgressAPI>()
    private let decoder = JSONDecoder()
    
    func fetchCalendarStats(userId: String, year: Int, month: Int) -> AnyPublisher<[CalendarSuccessRate], Error> {
        provider.requestPublisher(.getCalendar(userId: userId, year: year, month: month))
            .filterSuccessfulStatusCodes()
            .map(\.data)
            .decode(type: [CalendarSuccessRate].self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchWeeklyFeedback(userId: String) -> AnyPublisher<[WeeklyFeedback], Error> {
        provider.requestPublisher(.getWeeklyFeedback(userId: userId))
            .filterSuccessfulStatusCodes()
            .map(\.data)
            .decode(type: [WeeklyFeedback].self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
