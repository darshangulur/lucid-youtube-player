//
//  AppDelegate.swift
//  LucidPlaylistPlayer
//
//  Created by Darshan Gulur Srinivasa on 4/16/18.
//  Copyright © 2018 Lucid Infosystems. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        requestPermissionForLocalNotifications()

        let playlistViewController = PlaylistViewController()
        let navigationController = UINavigationController(rootViewController: playlistViewController)
        window?.rootViewController = navigationController
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

fileprivate extension AppDelegate {
    func requestPermissionForLocalNotifications() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound]) { [weak self] accepted, error in
                if !accepted {
                    print("Notification access denied. \(error?.localizedDescription ?? "No error description")")
                } else {
                    UNUserNotificationCenter.current().delegate = self
                    self?.setUpLocalNotification()
                }
        }
    }

    func setUpLocalNotification() {
        let date = Date(timeIntervalSinceNow: 10)
        let triggerDaily = Calendar.current.dateComponents([.hour, .minute, .second], from: date)
        let trigger: UNCalendarNotificationTrigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)

        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Hey! Don't forget to watch your playlist videos."
        content.categoryIdentifier = "watchCategory"
        let request = UNNotificationRequest(
            identifier: "watchRequest",
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current()
            .add(request) { error in
                print("\(error.debugDescription)")
        }
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let okayAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { alertAction in }

        let alert:UIAlertController = UIAlertController(
            title: notification.request.content.title,
            message: notification.request.content.body,
            preferredStyle: .alert
        )
        alert.addAction(okayAction)

        let navigationController = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
        navigationController.present(alert, animated: true, completion: nil)
        completionHandler([.alert, .sound])
    }
}
