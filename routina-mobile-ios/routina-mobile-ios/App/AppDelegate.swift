//
//  AppDelegate.swift
//  routina-mobile-ios
//
//  Created by 이재혁 on 6/5/25.
//

import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    // foreground 알림 감지
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
        if let alarmId = notification.request.content.userInfo["alarmId"] as? String {
            print("Foreground 감지한 id: \(alarmId)")
            UserDefaults.standard.set(alarmId, forKey: "launchedAlarmId")
        }
        NotificationCenter.default.post(name: .navigateToRoutine, object: nil)
    }
    
    // background
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
        if let alarmId = response.notification.request.content.userInfo["alarmId"] as? String {
            print("Background 감지한 id: \(alarmId)")
            UserDefaults.standard.set(alarmId, forKey: "launchedAlarmId")
        }
        UserDefaults.standard.set(true, forKey: "launchFromNotification")
    }
}
