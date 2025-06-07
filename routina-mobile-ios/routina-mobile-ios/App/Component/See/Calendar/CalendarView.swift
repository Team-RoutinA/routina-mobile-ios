//
//  CalendarView.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/28/25.
//

import SwiftUI
import FSCalendar

struct CalendarView: UIViewRepresentable {
    @ObservedObject var viewModel: CalendarViewModel

    // UIKit 뷰 생성
    func makeUIView(context: Context) -> FSCalendar {
        let calendar = FSCalendar()
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator

        // 사용자 정의 셀 등록
        calendar.register(CustomCalendarCell.self, forCellReuseIdentifier: "CustomCalendarCell")

        // 캘린더 배경 및 스타일
        calendar.backgroundColor = UIColor(Color.sub3Blue)
        calendar.layer.cornerRadius = 8
        calendar.layer.masksToBounds = true

        // 헤더 스타일
        calendar.appearance.headerDateFormat = "yyyy년 M월"
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.headerTitleFont = UIFont(name: "Pretendard-SemiBold", size: 12)
        calendar.headerHeight = 40
        calendar.appearance.headerMinimumDissolvedAlpha = 0

        // 날짜 텍스트 스타일
        calendar.appearance.titleDefaultColor = .black
        calendar.appearance.titleTodayColor = .black
        calendar.appearance.titleFont = UIFont(name: "Pretendard-SemiBold", size: 12)
        calendar.appearance.titleOffset = CGPoint(x: 0, y: -10)

        // 오늘 날짜 및 선택 스타일
        calendar.appearance.todayColor = .clear
        calendar.appearance.selectionColor = .clear
        calendar.allowsSelection = false
        calendar.weekdayHeight = 0

        return calendar
    }

    // SwiftUI 상태 반영 시 호출
    func updateUIView(_ uiView: FSCalendar, context: Context) {
        uiView.reloadData()
    }

    // 델리게이트, 데이터소스 담당할 코디네이터 생성
    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: viewModel)
    }

    // 델리게이트, 데이터소스 구현
    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource {
        var viewModel: CalendarViewModel
        //private var currentMonth: Date = Date()

        init(viewModel: CalendarViewModel) {
            self.viewModel = viewModel
        }

        // 날짜 셀에 대한 사용자 정의 셀 반환
        func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
            let cell = calendar.dequeueReusableCell(withIdentifier: "CustomCalendarCell", for: date, at: position) as! CustomCalendarCell

            // 현재 월, 과거/오늘 날짜일 경우에만 표시
            if viewModel.isDateInCurrentMonth(date),
               let progress = viewModel.progress(for: date) {
                cell.progressLabel.text = "\(progress)%"
                // 달성률에 따른 progress label 색상
                if progress < 30 {
                    cell.progressLabel.textColor = .routinaRed
                } else if progress > 70 {
                    cell.progressLabel.textColor = .routinaPurple
                } else {
                    cell.progressLabel.textColor = .routinaBlack
                }
            } else {
                cell.progressLabel.text = ""
            }

            // 오늘 날짜인 경우 흰색 원 표시
            if Calendar.current.isDateInToday(date) {
                cell.showTodayCircle()
            }

            return cell
        }

        // 날짜 텍스트 지정
        func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
            let formatter = DateFormatter()
            formatter.dateFormat = "d"
            return formatter.string(from: date)
        }

        // 현재 보고 있는 달이 바뀔 때 호출
        func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
            viewModel.currentMonth = calendar.currentPage
            calendar.reloadData()
        }
    }
}

struct CalendarPreview: View {
    @StateObject private var viewModel = CalendarViewModel()

    var body: some View {
        CalendarView(viewModel: viewModel)
            .frame(width: 345, height: 380)
            .padding()
    }
}

#Preview {
    CalendarPreview()
}
