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
        successNote: String?
    ) -> AnyPublisher<CreateRoutineResponse, Error> {
        
        let entity = CreateRoutineRequest(
            title: title,
            type: type,
            goal_value: goalValue,
            duration_seconds: durationSeconds,
            deadline_time: deadlineTime,
            success_note: successNote
        )
        
        // ✅ 실제 JSON 형태로 출력하기
        print("📤 루틴 생성 바디:")
        do {
            let jsonData = try JSONEncoder().encode(entity)
            let jsonString = String(data: jsonData, encoding: .utf8) ?? "JSON 변환 실패"
            print("실제 전송되는 JSON:")
            print(jsonString)
        } catch {
            print("❌ JSON 인코딩 에러: \(error)")
        }
        
        return provider.requestPublisher(.createRoutine(request: entity))
            .tryMap { response in
                guard (200..<300).contains(response.statusCode) else {
                    print("[RoutineService] createRoutine status: \(response.statusCode)")
                    
                    // ✅ 에러 응답을 더 자세히 분석
                    if let errorBody = String(data: response.data, encoding: .utf8) {
                        print("❌ 서버 에러 상세 내용: '\(errorBody)'")
                        print("❌ 에러 데이터 길이: \(response.data.count) bytes")
                    } else {
                        print("❌ 에러 응답을 문자열로 변환 실패")
                        print("❌ 원본 데이터: \(response.data)")
                    }
                    
                    throw MoyaError.statusCode(response)
                }
                // ✅ 성공 응답도 확인
                if let body = String(data: response.data, encoding: .utf8) {
                    print("📥 서버 성공 응답: \(body)")
                }

                return response.data
            }
            .decode(type: CreateRoutineResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
