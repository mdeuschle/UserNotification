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

    let center = UNUserNotificationCenter.current()

    override func viewDidLoad() {
        super.viewDidLoad()

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

    func scheduleNotifications(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {

        guard let imageURL = Bundle.main.url(forResource: "funny", withExtension: "gif") else {
            completion(false)
            return
        }

        var attachment: UNNotificationAttachment
        attachment = try! UNNotificationAttachment(identifier: "myNotification", url: imageURL, options: .none)
        let notif = UNMutableNotificationContent()
        notif.title = "Latte Sale!"
        notif.subtitle = "only $1.00"
        notif.body = "Choose your favorite flavor"
        notif.attachments = [attachment]


        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notifTrigger)

        center.add(request, withCompletionHandler: { error in
            if error != nil {
                completion(false)
                if let err = error {
                    print(err.localizedDescription)
                } else {
                    completion(true)
                }
            }
        })

    }

    @IBAction func SendNotificationButtonTapped(_ sender: UIButton) {
        scheduleNotifications(inSeconds: 5.0, completion: { success in
            if success {
                print("Notification successful")
            } else {
                print("Not suceesful")
            }
            
        })
        
    }
}

