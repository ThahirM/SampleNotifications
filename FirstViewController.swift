//
//  FirstViewController.swift
//  SampleNotifications
//
//  Created by Thahir Maheen on 8/11/18.
//  Copyright © 2018 Thahir Maheen. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, NotificationScheduler {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // schedule notification
        schedule(notification(with: "Test Notification"))
    }
}

