//
//  LocalNotification.swift
//  LucidYouTubePlayer
//
//  Created by Darshan Gulur Srinivasa on 5/27/18.
//  Copyright © 2018 Lucid Infosystems. All rights reserved.
//

import Foundation
import UserNotifications

final class LocalNotifications {
    static func setUpLocalNotification(hour: Int, minute: Int) {

        let date = Date(timeIntervalSinceNow: 2*60)
        let triggerDaily = Calendar.current.dateComponents([.hour, .minute, .second], from: date)
        let trigger: UNCalendarNotificationTrigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Watch you playlist videos!!"

        if let path = Bundle.main.path(forResource: "logo", ofType: "pdf") {
            let url = URL(fileURLWithPath: path)
            do {
                let attachment = try UNNotificationAttachment(
                    identifier: "logo",
                    url: url,
                    options: nil
                )
                content.attachments = [attachment]
            } catch {
                print("The attachment was not loaded.")
            }

            let request = UNNotificationRequest(
                identifier: content.title,
                content: content,
                trigger: trigger
            )

            UNUserNotificationCenter.current()
                .add(request) { error in
                    print("\(error.debugDescription)")
            }
        }
    }
}
