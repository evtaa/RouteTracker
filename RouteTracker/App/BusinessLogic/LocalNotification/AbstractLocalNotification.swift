//
//  AbstractLocalNotification.swift
//  RouteTracker
//
//  Created by Alexandr Evtodiy on 16.06.2021.
//

import Foundation
import UserNotifications
protocol AbstractLocalNotification {
    func removeNotification(identifiers: [String])
    func requestAuthorization()
    func setNotification(_ completionHandler: @escaping () -> Void)
    func makeNotificationContent(title: String, subtitle: String, body: String) -> UNNotificationContent
    func makeNotificationTrigger(timeInterval: Int, repeats: Bool) -> UNNotificationTrigger
    func sendNotificationRequest(identifier: String, content: UNNotificationContent, trigger: UNNotificationTrigger)
}
