//
//  AlarmCard.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/25/25.
//

import SwiftUI

struct AlarmCard: View {
    let timeText: String
    let weekdays: [String]
    let routines: [(title: String, type: String?)] // 루틴 제목 + 태그 타입
    @Binding var isOn: Bool
    let onDelete: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            // 요일 표시
            HStack(spacing: 8) {
                ForEach(weekdays, id: \.self) { day in
                    Text(day)
                        .font(.routina(.caption1))
                        .foregroundColor(Color.mainBlue)
                }
            }

            // 시간 + 토글
            HStack {
                Text(timeText)
                    .font(.routina(.h2))
                    .foregroundColor(.black)

                Spacer()

                Toggle("", isOn: $isOn)
                    .labelsHidden()
                    .toggleStyle(CustomToggle()) // 커스텀 토글 적용
            }

            // 루틴 표시 영역
            if isOn {
                // 전체 루틴 출력
                ForEach(routines.indices, id: \.self) { i in
                    HStack(alignment: .top, spacing: 6) {
                        Text(routines[i].title)
                            .font(.routina(.caption2))
                            .foregroundColor(.black)

                        if let type = routines[i].type {
                            Image(getTagImageName(from: type))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 14)
                        }
                    }
                }
            } else {
                // 꺼졌을 땐 첫 루틴 + "+N" 요약
                if let first = routines.first {
                    HStack(alignment: .top, spacing: 6) {
                        Text(first.title)
                            .font(.routina(.caption2))
                            .foregroundColor(.gray9)

                        if routines.count > 1 {
                            Text("+\(routines.count - 1)")
                                .font(.routina(.caption2))
                                .foregroundColor(.white)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color.gray7)
                                .cornerRadius(8)
                        }
                    }
                }
            }

            // 더보기 메뉴
            HStack {
                Spacer()
                Menu {
                    Button(role: .destructive) {
                        onDelete()
                    } label: {
                        Label("삭제하기", systemImage: "trash")
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(24)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }

    // 태그 이미지 매핑
    private func getTagImageName(from type: String) -> String {
        switch type {
        case "단순형": return "simpleChip"
        case "시간형": return "timeChip"
        case "개수형": return "numericChip"
        case "복합형": return "complexChip"
        default: return ""
        }
    }
}

struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State private var value: Value // 내부 상태 저장
    var content: (Binding<Value>) -> Content // 이 상태를 바인딩으로 넘김

    init(_ value: Value, content: @escaping (Binding<Value>) -> Content) {
        _value = State(initialValue: value) // 초기값 세팅
        self.content = content
    }

    var body: some View {
        content($value) // 바인딩 전달
    }
}

#Preview {
    StatefulPreviewWrapper(true) { $isOn in
        AlarmCard(
            timeText: "오전 6:20",
            weekdays: [],
            routines: [
                ("5분 동안 스트레칭", "시간형"),
                ("물 한 잔 마시기", "단순형"),
                ("출근 준비", "단순형"),
                ("오늘 일정 간단히 검토", "단순형"),
                ("아침 간식 준비 (바나나, 요거트)", "단순형"),
                ("출근 복장 최종 점검", "단순형")
            ],
            isOn: $isOn,
            onDelete: {}
        )
        .padding()
        .background(Color.gray.opacity(0.1))
    }
}
