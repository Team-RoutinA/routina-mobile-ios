//
//  RoutineOptionView.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/25/25.
//

import SwiftUI

// test
struct RoutineOptionView: View {
    @State private var goalCount: Int = 20
    @State private var durationMinutes: Int = 5

    var body: some View {
        VStack(spacing: 24) {
            CounterRow(title: "목표 개수", value: $goalCount, unit: "개")
            //CounterRow(title: "지속 시간", value: $durationMinutes, unit: "분")
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
    }
}

#Preview {
    RoutineOptionView()
        .padding()
}
