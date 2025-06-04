//
//  AlarmCard.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/25/25.
//

import SwiftUI

typealias AlarmRoutineInfo = (id: String, title: String, type: String?, deadline: Int?, successStandard: String?, goalCount: Int?)

struct AlarmCard: View {
    let timeText: String
    let weekdays: [String]
    let routines: [AlarmRoutineInfo]
    @Binding var isOn: Bool
    let onDelete: () -> Void
    let onToggle: (Bool) -> Void

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

                Toggle("", isOn: Binding(
                    get: { isOn },
                    set: { newValue in
                        print("🎯 토글 클릭: \(isOn) -> \(newValue)")
                        onToggle(newValue)
                    }
                ))
                .labelsHidden()
                .toggleStyle(CustomToggle())
            }

            // 루틴 표시 영역
            if isOn {
                ForEach(routines, id: \.id) { routine in
                    routineRow(for: routine)
                }
            } else if let first = routines.first {
                routineRow(for: first, collapsed: true)
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
    
    @ViewBuilder
    private func routineRow(for routine: AlarmRoutineInfo,
                            collapsed: Bool = false) -> some View {
        HStack(alignment: .top, spacing: 6) {
            Text(routine.title)
                .font(.routina(.caption2))
                .foregroundColor(collapsed ? .gray9 : .black)

            if let type = routine.type {
                Text(type)
                    .font(.routina(.caption3))
                    .foregroundColor(.white)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(
                        Capsule()
                            .fill(tagColor(for: type))
                    )
            }

            if collapsed, routines.count > 1 {
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

private func tagColor(for type: String) -> Color {
    switch type {
    case "단순형":   return .gray6
    case "시간형":   return .mainBlue.opacity(0.8)
    case "개수형":   return .orange.opacity(0.8)
    case "복합형":   return .purple.opacity(0.8)
    default:        return .gray4
    }
}

struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State private var value: Value
    var content: (Binding<Value>) -> Content
    init(_ value: Value, content: @escaping (Binding<Value>) -> Content) {
        _value = State(initialValue: value)
        self.content = content
    }
    var body: some View { content($value) }
}
