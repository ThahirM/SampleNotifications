//
//  NotificationScheduler.swift
//  SampleNotifications
//
//  Created by Thahir Maheen on 8/11/18.
//  Copyright © 2018 Thahir Maheen. All rights reserved.
//

import UserNotifications

protocol NotificationScheduler {
    func notification(with title: String, subtitle: String, body: String) -> UNMutableNotificationContent
    func schedule(_ notification: UNMutableNotificationContent, with identifier: String, when trigger: UNNotificationTrigger?)
}

extension NotificationScheduler {
    
    func notification(with title: String, subtitle: String = "", body: String = "") -> UNMutableNotificationContent {
        
        // create
        let notificationContent = UNMutableNotificationContent()
        
        // configure
        notificationContent.title = title
        notificationContent.subtitle = subtitle
        notificationContent.body = body
        
        // sound
        notificationContent.sound = UNNotificationSound.default()
        
        return notificationContent
    }
    
    func schedule(_ notification: UNMutableNotificationContent, with identifier: String = "EFNotification", when trigger: UNNotificationTrigger? = nil) {
        
        // trigger
        let notificationTrigger = trigger ?? UNTimeIntervalNotificationTrigger(timeInterval: 10.0, repeats: false)
        
        // request
        let notificationRequest = UNNotificationRequest(identifier: identifier, content: notification, trigger: notificationTrigger)
        
        // add request to notification center
        UNUserNotificationCenter.current().add(notificationRequest)
    }
}
