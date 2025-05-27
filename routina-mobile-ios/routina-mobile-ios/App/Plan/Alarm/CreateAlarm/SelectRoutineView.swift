//
//  SelectRoutineView.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/27/25.
//

import SwiftUI

struct SelectRoutineView: View {
    @ObservedObject var alarmViewModel: AlarmViewModel
    @ObservedObject var routineViewModel: RoutineViewModel
    @Environment(\.dismiss) var dismiss
    
    let alarmModel: AlarmModel
    
    @State private var selectedRoutines: [(title: String, type: String?)] = []
    @State private var isPresentingSelectRoutineView = false
    
    private var navigationTitle: String {
        "루틴 설정하기"
    }
    
    private var buttonTitle: String {
        "생성 완료"
    }
    
    var body: some View{
        ZStack {
            Color.white.ignoresSafeArea()
            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 20) {
                        // 제목
                        titleSection
                        
                        // 알람 시간
                        alarmTimeSection
                        
                        // 선택된 알람 루틴 (있을 때만 표시)
                        selectedRoutinesSection
                        
                        Rectangle()
                            .fill(Color.gray1)
                            .frame(height: 8)
                        
                        // 내 모든 루틴
                        myRoutinesSection
                    }
                }
                .padding(12)
                .padding(.horizontal, 8)
                .background(Color.white)
                
                // 생성 버튼
                actionButtonSection
            }
            .onReceive(NotificationCenter.default.publisher(for: .alarmCreated)) { _ in
                isPresentingSelectRoutineView = false
                print("알람 생성 완료 - CreateAlarmView 닫힘")
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(navigationTitle)
                        .font(.routina(.body_sb16))
                        .foregroundColor(.black)
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
    
    // MARK: - View Components

    private var titleSection: some View {
        Text("알람에 필요한 정보를 알려주세요")
            .padding(.horizontal, 20)
            .font(.routina(.h2))
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 12)
            .padding(.top, 16)
    }
    
    private var alarmTimeSection: some View {
        VStack(spacing: 0) {
            RoutineSelectRow(
                iconName: "alarm",
                title: alarmModel.timeText, // CreateAlarmView에서 받은 시간
                subtitle: "기상!",
                showChevron: false,
                isPlaceholder: false,
                onTap: {}
            )
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity)
        .background(Color.sub3Blue)
    }
    
    private func addToSelectedRoutines(_ routine: (title: String, type: String?)) {
        selectedRoutines.append(routine)
        print("루틴 추가: \(routine.title)")
    }
    
    private func removeFromSelectedRoutines(_ routine: (title: String, type: String?)) {
        selectedRoutines.removeAll { $0.title == routine.title }
        print("루틴 제거: \(routine.title)")
    }
    
    private func getIconName(for type: String?) -> String {
        guard let type = type else { return "simple" }
        
        switch type {
        case "개수형": return "numeric"
        case "시간형": return "time"
        case "단순형": return "simple"
        case "복합형": return "complex"
        default: return "simple"
        }
    }
    
    private func getDisplayType(for type: String?) -> String {
        return type ?? "단순형"
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
    
    private var selectedRoutinesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(spacing: 0) {
                if selectedRoutines.isEmpty {
                    Text("아래서 루틴을 선택해 주세요")
                        .font(.routina(.caption1))
                        .foregroundColor(.gray5)
                        .padding(.horizontal, 20)
                } else {
                    ForEach(selectedRoutines.indices, id: \.self) { index in
                        let routine = selectedRoutines[index]
                        RoutineSelectRow(
                            iconName: getIconName(for: routine.type),
                            title: routine.title,
                            subtitle: getDisplayType(for: routine.type),
                            showChevron: false,
                            isPlaceholder: false,
                            onTap: {
                                // 선택된 루틴에서 제거
                                removeFromSelectedRoutines(routine)
                            }
                        )
                    }
                }
            }
            .padding(.horizontal, 28)
            .background(Color.white)
        }
    }
    
    private var myRoutinesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("내 모든 루틴")
                .font(.routina(.h2))
                .foregroundColor(.black)
                .padding(.horizontal, 32)
            
            VStack(spacing: 0) {
                if routineViewModel.routines.isEmpty {
                    // 루틴이 없을 때 플레이스홀더
                    RoutineSelectRow(
                        iconName: "",
                        title: "아직 생성된 루틴이 없어요",
                        subtitle: nil,
                        showChevron: false,
                        isPlaceholder: true,
                        onTap: {}
                    )
                } else {
                    // 선택되지 않은 루틴들만 표시
                    let unselectedRoutines = routineViewModel.routines.filter { routine in
                        !selectedRoutines.contains { $0.title == routine.title }
                    }
                    
                    if unselectedRoutines.isEmpty {
                        // 모든 루틴이 선택된 경우
                        RoutineSelectRow(
                            iconName: "",
                            title: "모든 루틴을 선택했어요",
                            subtitle: nil,
                            showChevron: false,
                            isPlaceholder: true,
                            onTap: {}
                        )
                    } else {
                        ForEach(unselectedRoutines.indices, id: \.self) { index in
                            let routine = unselectedRoutines[index]
                            let routineTypeString = routine.routineType?.displayName
                            
                            RoutineSelectRow(
                                iconName: routine.icon,
                                title: routine.title,
                                subtitle: formatRoutineSubtitle(routine),
                                showChevron: false,
                                isPlaceholder: false,
                                onTap: {
                                    // 선택되지 않은 루틴이므로 추가
                                    addToSelectedRoutines((title: routine.title, type: routineTypeString))
                                }
                            )
                        }
                    }
                }
            }
            .background(Color.white)
            .padding(.horizontal, 28)
        }
    }
    
    private var actionButtonSection: some View {
        MainButton(
            text: "생성 완료",
            enable: !selectedRoutines.isEmpty,
            action: {
                let newAlarm = AlarmModel(
                    alarmTime: alarmModel.alarmTime,
                    weekdays: alarmModel.weekdays,
                    routines: selectedRoutines,
                    isOn: alarmModel.isOn,
                    volume: alarmModel.volume,
                    isVibrationOn: alarmModel.isVibrationOn
                )
                alarmViewModel.alarms.append(newAlarm)
                
                SnackBarPresenter.show(text: "알람이 성공적으로 생성되었습니다.", isSuccess: true)

                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    NotificationCenter.default.post(name: .alarmCreated, object: nil)
                }
            }
        )
        .padding(.horizontal, 20)
        .padding(.bottom, 16)
    }
}

#Preview {
    NavigationStack {
        SelectRoutineView(
            alarmViewModel: AlarmViewModel(),
            routineViewModel: RoutineViewModel(),
            alarmModel: AlarmModel(
                alarmTime: Calendar.current.date(from: DateComponents(hour: 20, minute: 26)) ?? Date(),
                weekdays: Set(["월", "화", "수"]),
                routines: [],
                isOn: true,
                volume: 0.5,
                isVibrationOn: true
            )
        )
    }
}

