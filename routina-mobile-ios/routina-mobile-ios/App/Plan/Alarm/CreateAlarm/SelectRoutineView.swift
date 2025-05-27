//
//  SelectRoutineView.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/27/25.
//

import SwiftUI

struct SelectRoutineView: View {
    @ObservedObject var viewModel: AlarmViewModel
    @Environment(\.dismiss) var dismiss
    
    let alarmModel: AlarmModel
    
    @State private var selectedRoutines: [String] = []
    @State private var showSnackBar: Bool = false
    
    private var navigationTitle: String {
        "루틴 설정하기"
    }
    
    private var buttonTitle: String {
        "생성 완료"
    }
    
    var body: some View{
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 20) {
                    // 제목
                    titleSection
                        .padding(.top, 12)
                        .padding(.horizontal, 12)
                    
                    alarmTimeSection
                }
            }
            .background(Color.white)
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
    }
    
    // MARK: - View Components

    private var titleSection: some View {
        Text("알람에 필요한 정보를 알려주세요")
            .font(.routina(.h2))
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            .padding(.top, 24)
    }
    
    private var alarmTimeSection: some View {
        VStack(spacing: 16) {
            // RoutineSelectRow를 사용해서 알람 시간 표시
            VStack(spacing: 0) {
                RoutineSelectRow(
                    iconName: "alarm", // 프로젝트에 있는 아이콘 사용
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
            
            // 구분선과 설명 텍스트
            VStack(spacing: 8) {
                Text("아래서 루틴을 선택해 주세요")
                    .font(.routina(.caption1))
                    .foregroundColor(.gray5)
                    .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    NavigationStack {
        CreateAlarmView(viewModel: AlarmViewModel())
    }
}
