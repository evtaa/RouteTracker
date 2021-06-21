//
//  LocalNotification.swift
//  RouteTracker
//
//  Created by Alexandr Evtodiy on 16.06.2021.
//

import Foundation
import UserNotifications

class LocalNotification: AbstractLocalNotification {
    // MARK: - Properties
    let notificationCenter = UNUserNotificationCenter.current()
    var countPendingNotifications: ((Int) -> Void)? {
        didSet {
            getCurrentNotifications() { [weak self] in
                self?.countPendingNotifications?($0.count)
            }
        }
    }
    
    // MARK: - Functions
    func getCurrentNotifications(completion: @escaping ([UNNotificationRequest]) -> Void) {
        notificationCenter.getPendingNotificationRequests(completionHandler: completion)
    }
    
    func requestAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            guard granted else {
                debugPrint("Разрешение не получено")
                return
            }
            debugPrint("Разрешение получено")
        }
    }
    
    func removeNotification(identifiers: [String])  {
        notificationCenter.removeDeliveredNotifications(withIdentifiers: identifiers)
    }
    
    func setNotification(_ completionHandler: @escaping () -> Void) {
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                debugPrint("Разрешения есть")
                completionHandler()
            case .denied:
                debugPrint("Разрешения отклонено")
            case .notDetermined:
                debugPrint("Не ясно есть разрешение или нет")
            default:
                debugPrint("Ошибка")
            }
        }
    }
    
    func makeNotificationContent(title: String, subtitle: String, body: String) -> UNNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        return content
    }
    
    func makeNotificationTrigger(timeInterval: Int, repeats: Bool) -> UNNotificationTrigger {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeInterval), repeats: repeats)
        return trigger
    }
    
    func sendNotificationRequest(identifier: String, content: UNNotificationContent, trigger: UNNotificationTrigger) {
        let request = UNNotificationRequest(identifier: identifier,
                                            content: content,
                                            trigger: trigger)
        notificationCenter.add(request) { (error) in
            guard let error = error else {return}
            debugPrint(error.localizedDescription)
        }
    }
}
