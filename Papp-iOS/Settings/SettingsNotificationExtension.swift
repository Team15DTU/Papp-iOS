//
//  SettingsNotificationExtension.swift
//  Papp-iOS
//
//  Created by Nikolaj Wassmann on 23/04/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import UIKit
import UserNotifications

extension SettingsCell {
    
    func addNotifications () {
        let userNotificationCenter = UNUserNotificationCenter.current()
        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
        userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
            if let error = error {
                print("Error: ", error)
                DispatchQueue.main.async {
                    self.permissionForNotification(false)
                }
                return
            }
            else if (!success){
                print("Permissions not given")
                DispatchQueue.main.async {
                    self.permissionForNotification(false)
                }
                return
            }
            else {
                print("Granted")
                DispatchQueue.main.async {
                    self.permissionForNotification(true)
                }
                
            }
        }
    }
    
   func showNotification (_ userNotificationCenter: UNUserNotificationCenter) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Parkering"
        notificationContent.body = "Der er en ledig parkingsplads nær dig "
        notificationContent.badge = 0
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2,
                                                        repeats: false)
        let request = UNNotificationRequest(identifier: "notification",
                                            content: notificationContent,
                                            trigger: trigger)
        
        userNotificationCenter.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }

}
