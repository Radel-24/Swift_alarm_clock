//
//  MyLocalNotificationBuilder.swift
//  techstack-swift
//
//  Created by Robin Adelwarth on 3/31/22.
//

import Foundation
import UserNotifications

class MyLocalNotificationBuilder {
    private let notificationCenter: UNUserNotificationCenter = UNUserNotificationCenter.current()
    private var notificationActions: [UNNotificationAction] = []
    private var notificationContent = UNMutableNotificationContent()
    
    func setActions() -> MyLocalNotificationBuilder {
        notificationActions.append(UNNotificationAction(identifier: "view", title: "View Photo in app", options: [.foreground,.authenticationRequired]))
        notificationActions.append(UNNotificationAction(identifier: "skip", title: "Skip", options: []))
        return self
    }
    
    func setCategory() -> MyLocalNotificationBuilder {
        let notificationCategory = UNNotificationCategory(identifier: "MyDailyClock", actions: notificationActions, intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "",options: .customDismissAction)
        notificationCenter.setNotificationCategories([notificationCategory])
        return self
    }
    
    func setContent() -> MyLocalNotificationBuilder {
        notificationContent.title = "My dayly clock title"
        notificationContent.body = "get up you fuckin bastard"
        notificationContent.categoryIdentifier = "MyDailyClock"
        notificationContent.userInfo = ["title": "My title for this", "description": "my descript alksdf aklfjklasjd asklfjaklsdjfklas fajsfaslk aklsfjakljfals dkfjalskfjaklsfjklajsdf jaklsdjklf"]
        return self
    }
    
    func build() {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "MyDailyClock", content: notificationContent, trigger: trigger)
        notificationCenter.add(request, withCompletionHandler: nil)
    }
}
