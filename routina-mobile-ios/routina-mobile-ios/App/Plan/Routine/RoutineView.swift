//
//  RoutineListView.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/25/25.
//

import SwiftUI

struct RoutineView: View {
    @ObservedObject var viewModel: RoutineViewModel
    @State private var isPresentingCreateView = false
    @State private var isPresentingEditView = false
    @State private var selectedRoutineIndex: Int?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    // 안내 텍스트
                    HStack {
                        Text("루틴을 만들거나 수정해 보세요")
                            .font(.routina(.h2))
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 8)
                    
                    // 루틴 생성 버튼
                    CreateRoutineButton(text: "루틴 생성하기") {
                        isPresentingCreateView = true
                    }
                    .padding(.horizontal, 24)
                    
                    // 루틴 리스트 박스
                    VStack(spacing: 0) {
                        ForEach(viewModel.routines.indices, id: \.self) { i in
                            RoutineSelectRow(
                                iconName: viewModel.routines[i].icon,
                                title: viewModel.routines[i].title,
                                subtitle: nil,
                                showChevron: true,
                                isPlaceholder: false,
                                onTap: {
                                    print("루틴 \(i) 선택됨: \(viewModel.routines[i].title)")
                                    print("총 루틴 개수: \(viewModel.routines.count)")
                                    selectedRoutineIndex = i
                                    isPresentingEditView = true
                                }
                            )
                        }
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 20)
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.horizontal, 24)
                    .padding(.top, 4)
                }
                .padding(.top, 20)
            }
            .background(Color.gray1.ignoresSafeArea())
        }
        .fullScreenCover(isPresented: $isPresentingCreateView) {
            NavigationStack {
                CreateRoutineView(viewModel: viewModel)
            }
        }
        .fullScreenCover(isPresented: $isPresentingEditView, onDismiss: {
            selectedRoutineIndex = nil
        }) {
            if let index = selectedRoutineIndex, index < viewModel.routines.count {
                NavigationStack {
                    CreateRoutineView(
                        viewModel: viewModel,
                        editingRoutine: viewModel.routines[index],
                        editingIndex: index
                    )
                }
            } else {
                // 안전장치: 인덱스가 유효하지 않을 경우 빈 뷰 대신 dismiss
                Color.clear
                    .onAppear {
                        isPresentingEditView = false
                    }
            }
        }
        .onAppear {
            viewModel.fetchRoutines()
        }
    }
}
