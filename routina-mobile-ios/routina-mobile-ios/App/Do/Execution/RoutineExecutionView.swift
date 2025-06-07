//
//  RoutineExecutionView.swift
//  routina-mobile-ios
//
//  Created by 이재혁 on 6/1/25.
//

import SwiftUI

struct RoutineExecutionView: View {
    @StateObject var viewModel = RoutineViewModel()
    let alarmModel: AlarmModel
    let routines: [RoutineDetail]
    let execID: String
    let dismissAlarmScreen: () -> Void
    @Environment(\.dismiss) var dismiss
    @State private var currentIndex = 0
        
    private var navigationTitle: String {
        "루틴 수행"
    }
    
    var body: some View {
        if currentIndex < routines.count {
            let routine = routines[currentIndex]
            
            VStack(spacing: 24) {
                switch routine.type {
                case "simple":
                    SimpleRoutineView(viewModel: viewModel, routine: routine, onComplete: nextRoutine)
                case "duration":
                    TimeRoutineView(viewModel: viewModel, routine: routine, onComplete: timeRoutineNextRoutine)
                case "numeric":
                    NumericRoutineView(viewModel: viewModel, routine: routine, onComplete: nextRoutine)
                case "complex":
                    ComplexRoutineView(viewModel: viewModel, alarmTime: alarmModel.alarmTime, routine: routine, onComplete: nextRoutine)
                default: EmptyView()
                }
                
                HStack(spacing: 0) {
                    RoutineControlButton(
                        imageName: "prev",
                        enable: currentIndex > 0,
                        text: "이전"
                    ) {
                        if currentIndex > 0 {
                            currentIndex -= 1
                        }
                    }
                    
                    RoutineControlButton(
                        imageName: "next",
                        isPrev: false,
                        enable: true,
                        text: "건너뛰기"
                    ) {
                            let skippedRoutineID = routines[currentIndex].routine_id
                            viewModel.failRoutine(skippedRoutineID)
                            
                            if currentIndex < routines.count - 1 {
                                currentIndex += 1
                            } else {
                                viewModel.sendRoutinesStatus(execID: execID)
                                dismiss()
                                dismissAlarmScreen()
                            }
                    }
                }
            }
            .navigationTitle(navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        viewModel.abortAllRoutines(force: true)
                        viewModel.sendRoutinesStatus(execID: execID)
                        
                        dismiss()
                        dismissAlarmScreen()
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 18, weight: .medium))
                        }
                        .foregroundColor(.black)
                    }
                }
            }
            .onAppear {
                print("routines.count =", routines.count)
                print("routines =", routines)
                if viewModel.routineStatuses.isEmpty {
                    viewModel.routineStatuses = routines.map {
                        RoutineStatus(
                            routine_id: $0.routine_id,
                            completed: false,
                            actual_value: nil,
                            completed_ts: nil,
                            abort_ts: nil
                        )
                    }
                }
            }
        } else {
            Text("루틴 없음: routines.count: \(routines.count)")
                .foregroundColor(.red)
        }
    }
    
    private func nextRoutine() {
            if currentIndex < routines.count - 1 {
                currentIndex += 1
            } else {
                // 루틴이 끝났을 때의 처리
                viewModel.sendRoutinesStatus(execID: execID)
                dismiss()
                dismissAlarmScreen()
            }
        
    }
    
    private func timeRoutineNextRoutine() {
        //if let routines = alarmModel.routineDetails {
            if currentIndex < routines.count - 1 {
                currentIndex += 1
            } else {
                viewModel.sendRoutinesStatus(execID: execID)
                dismiss()
                dismissAlarmScreen()
            }
        //}
    }
}

//#Preview {
//    RoutineExecutionView(alarmTime: Date(), routineViewModel: RoutineViewModel())
//}
