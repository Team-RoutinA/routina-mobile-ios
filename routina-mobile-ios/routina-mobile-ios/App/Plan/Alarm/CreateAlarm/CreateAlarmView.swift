//
//  CreateAlarmView.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/27/25.
//

import SwiftUI

struct CreateAlarmView: View {
    @ObservedObject var viewModel: AlarmViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var alarmTime: Date = Date()
    @State private var isShowingTimePicker: Bool = false
    @State private var volumeFloat: Float = 0.5
    @State private var isVibrationOn: Bool = true
    @State private var selectedWeekdays: Set<String> = []
    private let weekdays = ["일", "월", "화", "수", "목", "금", "토"]
    
    @State private var isPresentingSelectRoutineView = false
    
    private var navigationTitle: String {
        "알람 생성하기"
    }
    
    private var buttonTitle: String {
        "다음으로"
    }
    
    // 버튼 활성화 조건: 반복 요일이 하나 이상 선택되어야 함
    private var isButtonEnabled: Bool {
        !selectedWeekdays.isEmpty
    }
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 20) {
                        // 제목
                        titleSection
                        
                        // 알람 시간
                        alarmTimeSection
                        
                        // 음량 설정
                        volumeSection
                        
                        // 진동 여부
                        vibrationSection
                        
                        // 반복 요일
                        weekdaySelectionSection
                    }
                }
                .background(Color.white)
                
                // 다음으로 버튼
                actionButtonSection
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
            .fullScreenCover(isPresented: $isPresentingSelectRoutineView) {
                NavigationStack {
                    SelectRoutineView(
                        viewModel: viewModel,
                        alarmModel: AlarmModel(
                            alarmTime: alarmTime,
                            weekdays: selectedWeekdays,
                            routines: [],
                            isOn: true,
                            volume: Double(volumeFloat),
                            isVibrationOn: isVibrationOn
                        )
                    )
                }
            }
            .padding(12)
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
        VStack(alignment: .leading, spacing: 8) {
            Text("알람 시간")
                .font(.routina(.body_sb16))
                .foregroundColor(.black)
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
            
            Button(action: {
                isShowingTimePicker = true
            }) {
                HStack {
                    Text(formattedTime)
                        .foregroundColor(alarmTime == Date() ? .gray2 : .black)
                        .font(.routina(.body_m16))
                    Spacer()
                }
                .padding()
                .frame(height: 48)
                .background(Color.gray1)
                .cornerRadius(12)
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
            }
        }
        .sheet(isPresented: $isShowingTimePicker) {
            VStack {
                DatePicker(
                    "알람 시간 선택",
                    selection: $alarmTime,
                    displayedComponents: .hourAndMinute
                )
                .datePickerStyle(.wheel)
                .labelsHidden()
                .padding()

                HStack {
                    Button("Cancel") {
                        isShowingTimePicker = false
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.gray)

                    Button("Confirm") {
                        isShowingTimePicker = false
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.blue)
                }
                .padding(.horizontal)
            }
            .presentationDetents([.height(300)])
        }
    }

    private var formattedTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "a h:mm"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: alarmTime)
    }
    
    var volume: Double {
        Double(volumeFloat)
    }
    
    private var volumeSection: some View {
        HStack(spacing: 130){
            Text("음량")
                .font(.routina(.body_m16))
                .foregroundColor(.black)

            CustomSlider(value: $volumeFloat)
                    .frame(height: 30)
        }
        .padding(.horizontal, 20)
    }
    
    private var vibrationSection: some View {
        HStack {
            Text("진동")
                .font(.routina(.body_sb16))
                .foregroundColor(.black)
            
            Spacer()

            Toggle("", isOn: $isVibrationOn)
                .toggleStyle(CustomToggle())
        }
        .padding(.horizontal, 20)
    }
    
    private func toggleDay(_ day: String) {
        if selectedWeekdays.contains(day) {
            selectedWeekdays.remove(day)
        } else {
            selectedWeekdays.insert(day)
        }
    }
    
    private var weekdaySelectionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("반복 요일")
                .font(.routina(.body_sb16))
                .foregroundColor(.black)
                .padding(.horizontal, 20)

            HStack(spacing: 8) {
                ForEach(weekdays, id: \.self) { day in
                    Button(action: {
                        toggleDay(day)
                    }) {
                        Text(day)
                            .font(.routina(.body_sb16))
                            .frame(width: 36, height: 36)
                            .background(selectedWeekdays.contains(day) ? Color.sub3Blue : Color.gray1)
                            .foregroundColor(selectedWeekdays.contains(day) ? .mainBlue : .gray3)
                            .clipShape(Circle())
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
        }
    }
    
    private var actionButtonSection: some View {
        MainButton(
            text: buttonTitle,
            enable: isButtonEnabled,
            action: {
                isPresentingSelectRoutineView = true
            }
        )
        .padding(.bottom, 20)
    }
}

#Preview {
    NavigationStack {
        CreateAlarmView(viewModel: AlarmViewModel())
    }
}
