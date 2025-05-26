//
//  CreateRoutineView.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/26/25.
//

import SwiftUI

struct CreateRoutineView: View {
    @ObservedObject var viewModel: RoutineViewModel
    @Environment(\.dismiss) var dismiss

    @State private var routineName: String = ""
    @State private var selectedType: RoutineType = .numeric
    @State private var goalCount: Int = 0
    @State private var limitMinutes: Int = 0
    @State private var successStandard: String = ""
    
    @State private var showSnackBar: Bool = false
    @State private var isSuccessSnackBar: Bool = true

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 20) {
                    // 제목
                    titleSection
                    
                    // 루틴 제목
                    routineNameSection
                    
                    // 타입 선택 박스
                    typeSelectionSection
                    
                    // 타입 별 설명
                    typeDescriptionSection
                    
                    // 타입에 따라 조건별 컴포넌트 표시
                    counterSection
                    
                    // 성공 기준
                    successCriteriaSection
                }
            }
            .background(Color.white)
            
            // 루틴 생성 버튼
            createButtonSection
        }
        .background(Color.white)
        .navigationTitle("루틴 생성하기")
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
        .overlay(
            Group {
                if showSnackBar {
                    VStack {
                        Spacer()
                        SnackBar(
                            text: isSuccessSnackBar ? "루틴이 성공적으로 생성되었습니다." : "루틴 생성에 실패하였습니다.",
                            isSuccess: isSuccessSnackBar
                        )
                        .padding(.bottom, 20)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .animation(.easeInOut, value: showSnackBar)
                    }
                }
            }
        )
    }
    
    // MARK: - View Components
    
    // 제목
    private var titleSection: some View {
        Text("루틴에 필요한 정보를 알려주세요")
            .font(.routina(.h2))
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            .padding(.top, 24)
    }
    
    // 루틴 제목
    private var routineNameSection: some View {
        TextField("루틴 제목을 입력해 주세요", text: $routineName)
            .padding()
            .frame(height: 48)
            .background(Color.gray1)
            .cornerRadius(12)
            .foregroundColor(.black)
            .font(.routina(.body_m16))
            .accentColor(.mainBlue)
            .onAppear {
                UITextField.appearance().attributedPlaceholder = NSAttributedString(
                    string: "루틴 제목을 입력해 주세요",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
                )
            }
            .padding(.horizontal, 20)
    }
    
    // 타입 선택 박스
    private var typeSelectionSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                ForEach(RoutineType.allCases, id: \.self) { type in
                    Button {
                        selectedType = type
                    } label: {
                        HStack(spacing: 6) {
                            Image(type.tagIconName)
                                .resizable()
                                .frame(width: 22, height: 22)
                            
                            Text(type.displayName)
                                .font(.routina(.caption3))
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 8)
                        .background(selectedType == type ? Color.sub3Blue : Color.gray1)
                        .foregroundColor(selectedType == type ? Color.black : Color.gray5)
                        .cornerRadius(12)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.top, 8)
    }
    
    // 타입 별 설명
    private var typeDescriptionSection: some View {
        Text(selectedType.description)
            .font(.routina(.caption2))
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
    }
    
    // 타입에 따라 조건별 컴포넌트 표시
    private var counterSection: some View {
        Group {
            if selectedType == .numeric {
                VStack(spacing: 12) {
                    CounterRow(title: "목표 개수", value: $goalCount, unit: "개")
                    CounterRow(title: "마감 기한", value: $limitMinutes, unit: "분")
                }
            } else if selectedType == .time {
                VStack(spacing: 12) {
                    CounterRow(title: "지속 시간", value: $goalCount, unit: "분")
                    CounterRow(title: "마감 기한", value: $limitMinutes, unit: "분")
                }
            } else {
                // simple or complex
                CounterRow(title: "마감 기한", value: $limitMinutes, unit: "분")
            }
        }
        .onChange(of: selectedType) {
            goalCount = 0
            limitMinutes = 0
        }
        .padding(.horizontal, 20)
    }
    
    // 성공 기준
    private var successCriteriaSection: some View {
        VStack(spacing: 12) {
            Text("성공 기준")
                .font(.routina(.body_sb16))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, 12)
            
            TextField("나만의 성공 기준을 정해보세요", text: $successStandard)
                .padding()
                .frame(height: 48)
                .background(Color.gray1)
                .cornerRadius(12)
                .foregroundColor(.black)
                .font(.routina(.body_m16))
                .accentColor(.mainBlue)
                .onAppear {
                    UITextField.appearance().attributedPlaceholder = NSAttributedString(
                        string: "나만의 성공 기준을 정해보세요",
                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
                    )
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
        }
    }
    
    // 루틴 생성 버튼
    private var createButtonSection: some View {
        Button("루틴 생성") {
            if routineName.trimmingCharacters(in: .whitespaces).isEmpty {
                isSuccessSnackBar = false
                showSnackBar = true
            } else {
                let newRoutine = RoutineModel(title: routineName, icon: selectedType.tagIconName)
                viewModel.addRoutine(newRoutine)
                isSuccessSnackBar = true
                showSnackBar = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                    dismiss()
                }
            }
            
            // 자동으로 스낵바 숨기기
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                showSnackBar = false
            }
        }
        .font(.routina(.body_sb16))
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, minHeight: 48)
        .background(Color.mainBlue)
        .cornerRadius(12)
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
}

#Preview {
    NavigationStack {
        CreateRoutineView(viewModel: RoutineViewModel())
    }
}
