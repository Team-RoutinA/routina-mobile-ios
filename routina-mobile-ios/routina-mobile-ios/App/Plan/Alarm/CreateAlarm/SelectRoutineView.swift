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
    
    @State private var selectedRoutines: [RoutineModel] = []
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
            .onAppear {
                if routineViewModel.routines.isEmpty {
                    routineViewModel.fetchRoutines()
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
    
    private func addToSelectedRoutines(_ routine: RoutineModel) {
        selectedRoutines.append(routine)
    }

    private func removeFromSelectedRoutines(_ routine: RoutineModel) {
        selectedRoutines.removeAll { $0.id == routine.id }
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
                    ForEach(selectedRoutines, id: \.id) { routine in
                        RoutineSelectRow(
                            iconName: routine.icon,
                            title: routine.title,
                            subtitle: formatRoutineSubtitle(routine),
                            showChevron: false,
                            isPlaceholder: false,
                            onTap: {
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
                        !selectedRoutines.contains { $0.id == routine.id }
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
                                    addToSelectedRoutines(routine)
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
                let draft = AlarmModel(
                    alarmTime : alarmModel.alarmTime,
                    weekdays  : alarmModel.weekdays,
                    routines  : selectedRoutines.map {
                        (id: $0.routineId ?? "",
                         title: $0.title,
                         type:  $0.routineType?.displayName,
                         deadline: $0.limitMinutes,
                         successStandard: $0.successStandard,
                         goalCount: $0.goalCount)
                    },
                    isOn            : alarmModel.isOn,
                    volume          : alarmModel.volume,
                    isVibrationOn   : alarmModel.isVibrationOn
                )
                alarmViewModel.addAlarm(model: draft) { success, alarmId in
                    if success {
                        NotificationCenter.default.post(name: .alarmCreated, object: nil)
                        
                        // 알람 설정하기
                        scheduleAlarmNotifications(for: draft, alarmId: alarmId ?? "")
                        
                        dismiss()
                    }
                }
            }
        )
        .padding(.horizontal, 20)
        .padding(.bottom, 16)
    }
    
    private func scheduleAlarmNotifications(for draft: AlarmModel, alarmId: String) {
        let calendar = Calendar(identifier: .gregorian)
        let hour = calendar.component(.hour, from: draft.alarmTime)
        let minute = calendar.component(.minute, from: draft.alarmTime)
        let weekdayMap = ["일": 1, "월": 2, "화": 3, "수": 4, "목": 5, "금": 6, "토": 7]
        print("----생성된 알람Id: \(alarmId)----")
        for weekday in draft.weekdays {
            if let weekdayInt = weekdayMap[weekday] {
                NotificationService.scheduleNotification(alarmId: alarmId, weekday: weekdayInt, hour: hour, minute: minute)
            }
        }
    }
}
