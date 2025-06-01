//
//  RoutineService.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 6/1/25.
//
import Foundation
import Moya
import Combine
import CombineMoya

class RoutineService {
    private var provider = MoyaProvider<RoutineAPI>()
    
    func createRoutine(
        userId: String,
        title: String,
        type: String,
        goalValue: Int?,
        durationSeconds: Int?,
        deadlineTime: String,
        successNote: String
    ) -> AnyPublisher<Base<CreateRoutineResponse>, Error> {
        let entity = CreateRoutineRequest(
            user_id: userId,
            title: title,
            type: type,
            goal_value: goalValue,
            duration_seconds: durationSeconds,
            deadline_time: deadlineTime,
            success_note: successNote
        )
        
        return provider.requestPublisher(.createRoutine(request: entity))
            .tryMap { response in
                guard (200..<300).contains(response.statusCode) else {
                    print("[RoutineService] creteRoutine status: \(response.statusCode)")
                    throw MoyaError.statusCode(response)
                }
                return response.data
            }
            .decode(type: Base<CreateRoutineResponse>.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
