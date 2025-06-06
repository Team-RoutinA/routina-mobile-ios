//
//  RoutineExecutionView.swift
//  routina-mobile-ios
//
//  Created by 이재혁 on 6/1/25.
//

import SwiftUI

struct RoutineExecutionView: View {
    let alarmModel: AlarmModel
    let routines: [RoutineDetail]
    @Environment(\.dismiss) var dismiss
    @State private var currentIndex = 0
        
    private var navigationTitle: String {
        "루틴 수행"
    }
    
    var body: some View {
        if let routine = alarmModel.routineDetails?[currentIndex] {
            VStack(spacing: 24) {
                switch routine.type {
                case "simple":
                    SimpleRoutineView(routine: routine, onComplete: nextRoutine)
                case "duration":
                    TimeRoutineView(routine: routine, onComplete: timeRoutineNextRoutine)
                case "numeric":
                    NumericRoutineView(routine: routine, onComplete: nextRoutine)
                case "complex":
                    ComplexRoutineView(alarmTime: alarmModel.alarmTime, routine: routine, onComplete: nextRoutine)
                default: EmptyView()
                }
                
                HStack(spacing: 0) {
                    RoutineControlButton(imageName: "prev", text: "이전") {}
                    
                    RoutineControlButton(imageName: "next", isPrev: false, text: "건너뛰기") {nextRoutine()}
                }
            }
            .navigationTitle(navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 18, weight: .medium))
                        }
                        .foregroundColor(.black)
                    }
                }
            }
        }
    }
    
    private func nextRoutine() {
        //if currentIndex < routineViewModel.routines.count - 1 {
        if let routines = alarmModel.routineDetails {
            if currentIndex < routines.count - 1 {
                currentIndex += 1
            }
            // 루틴이 끝났을 때의 처리
        }
        
    }
    
    private func timeRoutineNextRoutine() {
        
    }
}

//#Preview {
//    RoutineExecutionView(alarmTime: Date(), routineViewModel: RoutineViewModel())
//}
