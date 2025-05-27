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
    
    // 수정 모드를 위한 프로퍼티
    let editingRoutine: RoutineModel?
    let editingIndex: Int?
    
    @State private var routineName: String = ""
    @State private var selectedType: RoutineType = .numeric
    @State private var goalCount: Int = 0
    @State private var limitMinutes: Int = 0
    @State private var successStandard: String = ""
    
    @State private var showSnackBar: Bool = false
    @State private var isSuccessSnackBar: Bool = true
    @State private var hasInitialized = false
    @State private var refreshTrigger = false
    
    @State private var isShowingDeleteAlert = false
    
    // 생성 모드용 이니셜라이저
    init(viewModel: RoutineViewModel) {
        self.viewModel = viewModel
        self.editingRoutine = nil
        self.editingIndex = nil
    }
    
    // 수정 모드용 이니셜라이저
    init(viewModel: RoutineViewModel, editingRoutine: RoutineModel, editingIndex: Int) {
        self.viewModel = viewModel
        self.editingRoutine = editingRoutine
        self.editingIndex = editingIndex
    }
    
    private var isEditMode: Bool {
        editingRoutine != nil
    }
    
    private var navigationTitle: String {
        isEditMode ? "루틴 수정하기" : "루틴 생성하기"
    }
    
    private var buttonTitle: String {
        isEditMode ? "루틴 수정" : "루틴 생성"
    }

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
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
                        
                        // 삭제 버튼
                        if isEditMode {
                            deleteTextButtonSection
                        }
                    }
                }
                .background(Color.white)
                
                // 루틴 생성/수정 버튼
                actionButtonSection
            }
            .background(Color.white)
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
            .onAppear {
                if let routine = editingRoutine {
                    // 강제로 값 설정
                    DispatchQueue.main.async {
                        self.routineName = routine.title
                        self.selectedType = routine.routineType ?? self.getRoutineType(from: routine.icon)
                        self.goalCount = routine.goalCount ?? 0
                        self.limitMinutes = routine.limitMinutes ?? 0
                        self.successStandard = routine.successStandard ?? ""
                    }
                }
                setupInitialValues()
            }
            .overlay(
                Group {
                    if showSnackBar {
                        VStack {
                            Spacer()
                            SnackBar(
                                text: isSuccessSnackBar ?
                                (isEditMode ? "루틴이 성공적으로 수정되었습니다." : "루틴이 성공적으로 생성되었습니다.") :
                                    (isEditMode ? "루틴 수정에 실패하였습니다." : "루틴 생성에 실패하였습니다."),
                                isSuccess: isSuccessSnackBar
                            )
                            .padding(.bottom, 20)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                            .animation(.easeInOut, value: showSnackBar)
                        }
                    }
                }
            )
            .alert("정말 삭제하시겠어요?", isPresented: $isShowingDeleteAlert) {
                Button("삭제", role: .destructive) {
                    if let index = editingIndex {
                        viewModel.deleteRoutine(at: index)
                        dismiss()
                    }
                }
                Button("취소", role: .cancel) { }
            }

            .padding(12)
        }
    }
    
    // MARK: - Setup Methods
    
    private func setupInitialValues() {
        if let routine = editingRoutine, !hasInitialized {
            self.routineName = routine.title // 즉시 값 설정
            self.selectedType = routine.routineType ?? self.getRoutineType(from: routine.icon) // 저장된 타입이 있으면 사용, 없으면 아이콘으로 추론
            self.goalCount = routine.goalCount ?? 0
            self.limitMinutes = routine.limitMinutes ?? 0
            self.successStandard = routine.successStandard ?? ""
            self.hasInitialized = true
            
            // UI 강제 새로고침
            DispatchQueue.main.async {
                self.refreshTrigger.toggle()
            }
        }
    }
    
    private func getRoutineType(from iconName: String) -> RoutineType {
        print("아이콘 이름으로 타입 추론: '\(iconName)'")
        
        switch iconName {
        case "numeric":
            print("-> numeric 타입으로 추론")
            return .numeric
        case "time":
            print("-> time 타입으로 추론")
            return .time
        case "simple":
            print("-> simple 타입으로 추론")
            return .simple
        case "complex":
            print("-> complex 타입으로 추론")
            return .complex
        default:
            print("-> 알 수 없는 아이콘, numeric으로 기본 설정")
            return .numeric
        }
    }
    
    // MARK: - View Components
    
    private var titleSection: some View {
        Text("루틴에 필요한 정보를 알려주세요")
            .font(.routina(.h2))
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            .padding(.top, 24)
    }
    
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
    
    private var typeSelectionSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                ForEach(RoutineType.allCases, id: \.self) { type in
                    Button {
                        selectedType = type
                    } label: {
                        HStack(spacing: 6) {
                            Image(type.tagImageName)
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
    
    private var typeDescriptionSection: some View {
        Text(selectedType.description)
            .font(.routina(.caption2))
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
    }
    
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
        .id(refreshTrigger) // 강제 새로고침을 위한 id
        .onChange(of: selectedType) {
            // 수정 모드에서 초기 로딩이 완료된 후에만 초기화
            if !isEditMode || hasInitialized {
                goalCount = 0
                limitMinutes = 0
            }
        }
        .padding(.horizontal, 20)
    }
    
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
                //.padding(.bottom, 20)
        }
    }
    
    private var deleteTextButtonSection: some View {
        Button(action: {
            isShowingDeleteAlert = true
        }) {
            Text("루틴 삭제하기")
                .font(.routina(.button14))
                .foregroundColor(.red)
                .underline()
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 20)
                .padding(.horizontal, 20)
        }
        .padding(.top, 10)
    }
    
    private var actionButtonSection: some View {
        MainButton(
            text: buttonTitle,
            enable: !routineName.trimmingCharacters(in: .whitespaces).isEmpty,
            action: {
                if routineName.trimmingCharacters(in: .whitespaces).isEmpty {
                    isSuccessSnackBar = false
                    showSnackBar = true
                } else {
                    let routine = RoutineModel(
                        title: routineName,
                        icon: selectedType.tagImageName,
                        routineType: selectedType,
                        goalCount: goalCount > 0 ? goalCount : nil,
                        limitMinutes: limitMinutes > 0 ? limitMinutes : nil,
                        successStandard: successStandard.trimmingCharacters(in: .whitespaces).isEmpty ? nil : successStandard
                    )
                    
                    if isEditMode {
                        // 수정 모드
                        if let index = editingIndex {
                            viewModel.updateRoutine(at: index, with: routine)
                        }
                    } else {
                        // 생성 모드
                        viewModel.addRoutine(routine)
                    }
                    
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
        )
        .padding(.bottom, 20)
    }
}

#Preview {
    NavigationStack {
        CreateRoutineView(viewModel: RoutineViewModel())
    }
}
