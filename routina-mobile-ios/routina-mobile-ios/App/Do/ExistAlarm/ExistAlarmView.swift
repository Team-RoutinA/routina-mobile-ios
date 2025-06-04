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
    
    let alarmModel: AlarmModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                HStack {
                    titleSection
                    Spacer()
                }
                
                alarmSection
                
                routineSection
            }
        }
    }
    
    private var titleSection: some View {
        Text("예정된 알람")
            .font(.routina(.h1))
            .padding(.horizontal, 24)
    }
    
    private var alarmSection: some View {
        VStack(spacing: 0) {
            RoutineSelectRow(
                iconName: "alarm",
                title: alarmModel.timeText,
                subtitle: "기상!",
                showChevron: false,
                isPlaceholder: false,
                onTap: {}
            )
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 6)
        .frame(maxWidth: .infinity)
        .background(.sub3Blue)
    }
    
    private var routineSection: some View {
        VStack(spacing: 0) {
            if routineViewModel.routines.isEmpty {
                RoutineSelectRow(
                    iconName: "",
                    title: "아직 생성된 루틴이 없어요",
                    subtitle: nil,
                    showChevron: false,
                    isPlaceholder: true,
                    onTap: {}
                )
            } else {
                let routines = routineViewModel.routines
                ForEach(routines.indices, id: \.self) { index in
                    let routine = routines[index]
                    let routineTypeString = routine.routineType?.displayName
                    
                    RoutineSelectRow(
                        iconName: routine.icon,
                        title: routine.title,
                        subtitle: formatRoutineSubtitle(routine),
                        showChevron: false,
                        isPlaceholder: false,
                        onTap: {}
                    )
                }
            }
        }
        .padding(.horizontal, 24)
        .background(.white)
        .frame(maxWidth: .infinity)
    }
    
    private func formatRoutineSubtitle(_ routine: RoutineModel) -> String? {
        var components: [String] = []
        
        // 타입별 목표/지속 시간 정보
        if let goalCount = routine.goalCount {
            switch routine.routineType {
            case .numeric:
                components.append("목표 \(goalCount)개")
            case .time:
                components.append("지속 \(goalCount)분")
            default:
                break
            }
        }
        
        // 마감 기한
        if let limitMinutes = routine.limitMinutes {
            components.append("마감 \(limitMinutes)분")
        }
        
        // 성공 기준
        if let successStandard = routine.successStandard, !successStandard.isEmpty {
            components.append(successStandard)
        }
        
        return components.isEmpty ? routine.routineType?.displayName : components.joined(separator: " • ")
    }
}

#Preview {
    ExistAlarmView(alarmViewModel: AlarmViewModel(), routineViewModel: RoutineViewModel(), alarmModel: AlarmModel(
        alarmTime: Calendar.current.date(from: DateComponents(hour: 20, minute: 26)) ?? Date(),
        weekdays: Set(["월", "화", "수"]),
        routines: [],
        isOn: true,
        volume: 0.5,
        isVibrationOn: true
    ))
}
