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
    
    private var navigationTitle: String {
        "알람 생성하기"
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 20) {
                    // 제목
                    titleSection
                    
                    // 알람 시간
                    alarmTimeSection
                }
            }
                
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
        .padding(12)
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
                .font(.routina(.body_m16))
                .foregroundColor(.black)
                .padding(.horizontal, 20)
            
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
}

#Preview {
    NavigationStack {
        CreateAlarmView(viewModel: AlarmViewModel())
    }
}
