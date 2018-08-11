//
//  NotificationManager.swift
//  SampleNotifications
//
//  Created by Thahir Maheen on 8/11/18.
//  Copyright © 2018 Thahir Maheen. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationManager {
    
    static let shared = NotificationManager()
    static let notificationManagerDelegate = NotificationManagerDelegate()
    
    private init() {
        notificationManagerDelegate = NotificationManagerDelegate()
        UNUserNotificationCenter.current().delegate = notificationManagerDelegate
    }
    
    private (set) var notificationManagerDelegate: NotificationManagerDelegate?
    var stepsManager: NotificationManager?
    
    func register(completionHandler: ((_ success: Bool, _ error: Error?) -> Void)? = nil) {
        // request for permission and if yes register for push notification
        let requestAuthorization = { (completion: @escaping (() -> Void)) in
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (success, error) in
                
                // handle error cases
                guard error == nil else {
                    completionHandler?(false, error)
                    return
                }
                
                // continue only if its success
                guard success else {
                    completionHandler?(false, nil)
                    return
                }
                
                // register for remote notifications
                UIApplication.shared.registerForRemoteNotifications()
                
                // fire completion handler
                completion()
            }
        }
        
        // get user notification settings
        UNUserNotificationCenter.current().getNotificationSettings { [weak self] (settings) in
            switch settings.authorizationStatus {
            case .denied:
                completionHandler?(false, nil)
                return
                
            case .authorized:
                completionHandler?(true, nil)
                return
                
            case .notDetermined:
                requestAuthorization {
                    self?.register(completionHandler: completionHandler)
                }
            }
        }
    }
}

extension NotificationManager {
    
    class NotificationManagerDelegate: NSObject, UNUserNotificationCenterDelegate {
        
        func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            completionHandler([.alert, .sound, .badge])
        }
        
        func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

            completionHandler()
        }
    }
}
