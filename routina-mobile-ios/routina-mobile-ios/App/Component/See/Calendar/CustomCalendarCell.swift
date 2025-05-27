//
//  CustomCalendarCell.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/28/25.
//

import FSCalendar
import UIKit

class CustomCalendarCell: FSCalendarCell {
    weak var progressLabel: UILabel! // 달성률(%)을 표시하는 라벨
    private var todayCircleLayer: CAShapeLayer? // 오늘 날짜를 감싸는 흰색 동그라미 레이어

    override init(frame: CGRect) {
        super.init(frame: frame)

        // 달성률 라벨 스타일 설정
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: "Pretendard-Regular", size: 10)
        // 셀에 추가
        contentView.insertSubview(label, at: 0)
        self.progressLabel = label
    }

    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }

    // 레이아웃 업데이트
    override func layoutSubviews() {
        super.layoutSubviews()
        progressLabel.frame = CGRect(x: 0, y: contentView.bounds.height - 23, width: contentView.bounds.width, height: 20)
        contentView.bringSubviewToFront(progressLabel)
    }

    // 오늘 날짜 흰색 동그라미 표시
    func showTodayCircle() {
        let radius: CGFloat = min(bounds.width, bounds.height) * 0.6
        let circlePath = UIBezierPath(ovalIn: CGRect(
            x: (bounds.width - radius) / 2,
            y: (bounds.height - radius) / 2 - 15,
            width: radius,
            height: radius
        ))

        let circle = CAShapeLayer()
        circle.path = circlePath.cgPath
        circle.fillColor = UIColor.white.cgColor
        contentView.layer.insertSublayer(circle, below: titleLabel!.layer)
        self.todayCircleLayer = circle
    }

    // 셀 재사용 시 초기화
    override func prepareForReuse() {
        super.prepareForReuse()
        progressLabel.text = nil
        todayCircleLayer?.removeFromSuperlayer()
    }
}

