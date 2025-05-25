//
//  AlarmListView.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/25/25.
//

import SwiftUI

struct AlarmView: View {
    @ObservedObject var viewModel: AlarmViewModel

    // 임시로 가장 가까운 알람 시간 기준 남은 시간 텍스트 계산
    var nextAlarmText: String {
        // 실제 서버 연결 시 viewModel에서 nextAlarm까지 계산
        // 여기서는 첫 번째 알람 시간 하드코딩 기준으로 예시
        return "1시간 19분 후 울려요"
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                // 알람 남은 시간 텍스트
                HStack {
                    Text(nextAlarmText)
                        .font(.routina(.body_sb16))
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding(.horizontal, 50)
                .padding(.bottom, 8)

                // 알람 생성하기 버튼
                CreateAlarmButton(text: "+ 알람 생성하기") {
                    print("알람 생성 버튼 눌림")
                }
                .padding(.horizontal, 24)

                // 알람 카드 리스트
                ForEach(viewModel.alarms.indices, id: \.self) { i in
                    AlarmCard(
                        timeText: viewModel.alarms[i].timeText,
                        weekdays: viewModel.alarms[i].weekdays,
                        routines: viewModel.alarms[i].routines,
                        isOn: $viewModel.alarms[i].isOn,
                        onMoreTapped: {
                            print("더보기 눌림: \(viewModel.alarms[i].timeText)")
                        }
                    )
                    .padding(.horizontal, 48)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 18)
        }
    }
}

//#Preview {
//    AlarmView(viewModel: AlarmViewModel())
//}

#Preview {
    PlanView()
}
