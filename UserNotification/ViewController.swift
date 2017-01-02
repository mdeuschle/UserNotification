//
//  ViewController.swift
//  UserNotification
//
//  Created by Matt Deuschle on 1/2/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (response, error) in
            if response {
                print("Permission Granted")
            } else {
                if let err = error {
                    print(err.localizedDescription)
                }
            }
        })
    }
}

