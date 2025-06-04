//
//  RoutineExecutionView.swift
//  routina-mobile-ios
//
//  Created by 이재혁 on 6/1/25.
//

import SwiftUI

struct RoutineExecutionView: View {
    var alarmTime: Date
    @ObservedObject var viewModel: RoutineViewModel
    @Environment(\.dismiss) var dismiss
    @State private var currentIndex = 0
        
    private var navigationTitle: String {
        "루틴 수행"
    }
    
    var body: some View {
        let routine = viewModel.routines[currentIndex]
        
        VStack(spacing: 24) {
            switch routine.routineType {
            case .simple:
                SimpleRoutineView(routine: routine, onComplete: nextRoutine)
            case .time:
                TimeRoutineView(routine: routine, onComplete: timeRoutineNextRoutine)
            case .numeric:
                NumericRoutineView(routine: routine, onComplete: nextRoutine)
            case .complex:
                ComplexRoutineView(alarmTime: alarmTime, routine: routine, onComplete: nextRoutine)
            case .none:
                EmptyView()
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
    
    private func nextRoutine() {
        if currentIndex < viewModel.routines.count - 1 {
            currentIndex += 1
        }
        // 루틴이 끝났을 때의 처리
    }
    
    private func timeRoutineNextRoutine() {
        
    }
}

#Preview {
    RoutineExecutionView(alarmTime: Date(), viewModel: RoutineViewModel())
}
