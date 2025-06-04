//
//  ExistAlarmView.swift
//  routina-mobile-ios
//
//  Created by 이재혁 on 6/1/25.
//

import SwiftUI

struct ExistAlarmView: View {
    @ObservedObject var alarmViewModel: AlarmViewModel
    @ObservedObject var routineViewModel: RoutineViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                HStack {
                    titleSection
                    Spacer()
                }
                let alarmModels = alarmViewModel.filteredAlarms()
                ForEach(alarmModels.indices, id: \.self) { index in
                    alarmSection(for: alarmModels[index])
                    routineSection(for: alarmModels[index].routines)
                }
            }
        }
    }
    
    private var titleSection: some View {
        Text("예정된 알람")
            .font(.routina(.h1))
            .padding(.horizontal, 24)
    }
    
    private func alarmSection(for alarm: AlarmModel) -> some View {
        RoutineSelectRow(
            iconName: "alarm",
            title: alarm.timeText,
            subtitle: "기상!",
            showChevron: false,
            isPlaceholder: false,
            onTap: {}
        )
        .padding(.horizontal, 24)
        .padding(.vertical, 6)
        .frame(maxWidth: .infinity)
        .background(.sub3Blue)
    }
    
    private func routineSection(for routines: [AlarmRoutineInfo]) -> some View {
        VStack(spacing: 0) {
            if routines.isEmpty {
                RoutineSelectRow(
                    iconName: "",
                    title: "아직 생성된 루틴이 없어요",
                    subtitle: nil,
                    showChevron: false,
                    isPlaceholder: true,
                    onTap: {}
                )
            } else {
                ForEach(routines, id: \.id) { routine in
                    routineRow(for: routine)
                }
            }
        }
        .padding(.horizontal, 24)
        .background(.white)
        .frame(maxWidth: .infinity)
    }
    
    private func formatRoutineSubtitle(_ routine: AlarmRoutineInfo) -> String? {
        var components: [String] = []
        
        // 타입별 목표/지속 시간 정보
        if let goalCount = routine.goalCount, let routineType = routine.type {
            switch routineType {
            case "정량형":
                components.append("목표 \(goalCount)개")
            case "시간형":
                components.append("지속 \(goalCount)분")
            default:
                break
            }
        }
        
        // 마감 기한
        if let limitMinutes = routine.deadline {
            components.append("마감 \(limitMinutes)분")
        }
        
        // 성공 기준
        if let successStandard = routine.successStandard, !successStandard.isEmpty {
            components.append(successStandard)
        }
        
        return components.isEmpty ? routine.type : components.joined(separator: " • ")
    }
    
    @ViewBuilder
    private func routineRow(for routine: AlarmRoutineInfo) -> some View {
        if let type = routine.type {
            RoutineSelectRow(
                iconName: getTypeImageName(from: type),
                title: routine.title,
                subtitle: formatRoutineSubtitle(routine),
                showChevron: false,
                isPlaceholder: false,
                onTap: {}
            )
        }
    }
    
    private func getTypeImageName(from type: String) -> String {
        switch type {
        case "단순형": return "simple"
        case "시간형": return "time"
        case "정량형": return "numeric"
        case "복합형": return "complex"
        default: return ""
        }
    }
}

#Preview {
    ExistAlarmView(alarmViewModel: AlarmViewModel(), routineViewModel: RoutineViewModel())
}
