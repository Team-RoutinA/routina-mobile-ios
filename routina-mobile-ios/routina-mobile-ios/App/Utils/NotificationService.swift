//
//  NotificationService.swift
//  routina-mobile-ios
//
//  Created by 이재혁 on 6/5/25.
//

import Foundation
import UserNotifications

enum NotificationService {
    static func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("✅ 알림 권한 허용됨")
            } else {
                print("❌ 알림 권한 거부됨")
            }
        }
    }
    
    static func scheduleNotification(weekday: Int, hour: Int, minute: Int) {
        let content = UNMutableNotificationContent()
        content.title = "루틴 알림"
        content.body = "지금 루틴을 시작할 시간이에요!"
        content.sound = .default
        content.userInfo = ["type": "routine"]
        
        var dateComponents = DateComponents()
        dateComponents.weekday = weekday
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ 반복 알림 등록 실패: \(error)")
            } else {
                print("✅ 반복 알림 등록 성공: \(weekday)요일 \(hour):\(minute)")
            }
        }
    }
    
    // 나중에 삭제
//    static func scheduleNotification2(at date: Date) {
//        let content = UNMutableNotificationContent()
//        content.title = "루틴 알림"
//        content.body = "지금 루틴을 시작할 시간이에요!"
//        content.sound = .default
//        content.userInfo = ["type": "routine"]
//        
//        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
//        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
//        
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//        UNUserNotificationCenter.current().add(request) { error in
//            if let error = error {
//                print("❌ 알림 등록 실패: \(error)")
//            } else {
//                print("✅ 알림 등록 성공")
//            }
//        }
//    }
}
