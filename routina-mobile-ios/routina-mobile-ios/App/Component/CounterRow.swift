//
//  RoutineOption.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/25/25.
//
import SwiftUI

struct CounterRow: View {
    let title: String              // 항목 이름 (예: "목표 개수")
    @Binding var value: Int       // 값 (예: 20)
    let unit: String              // 단위 (예: "개")

    var body: some View {
        HStack {
            // 항목 타이틀
            Text(title)
                .font(.routina(.body_sb16))
                .foregroundColor(.black)

            Spacer()

            // [- 20 +] 부분
            HStack(spacing: 16) {
                // ➖ 버튼
                Button(action: {
                    if value > 0 { value -= 1 }
                }) {
                    Image("minus")
                        .resizable()
                        .frame(width: 18, height: 3)
                }

                // 숫자 표시
                Text("\(value)")
                    .font(.routina(.body_sb16))
                    .foregroundColor(.black)
                    .frame(minWidth: 16)

                // ➕ 버튼
                Button(action: {
                    value += 1
                }) {
                    Image("plus")
                        .resizable()
                        .frame(width: 18, height: 18)
                }
            }
            .frame(width: 96, height: 36)
            .padding(.horizontal, 10)
            .padding(.vertical, 2)
            .background(Color.sub3Blue)
            .cornerRadius(16)

            // 단위
            Text(unit)
                .font(.routina(.body_sb16))
                .foregroundColor(.black)
        }
    }
}

#Preview {
    RoutineOptionView()
        .padding()
}
