//
//  AppDelegate.swift
//  Push Notificatons
//
//  Created by Powerplay on 04/05/23.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        registerForPushNotifications()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

extension AppDelegate {
    private func registerForPushNotifications() {
        /// Setting the delegate so we can receive delegate callbacks
        UNUserNotificationCenter.current().delegate = self
        
        // 1
        let viewAction = UNNotificationAction(
            identifier: "identifier",
            title: "View",
            options: [.foreground])
        
        // 2
        let newsCategory = UNNotificationCategory(
            identifier: "identifier",
            actions: [viewAction],
            intentIdentifiers: [],
            options: [])
        
        // 3
        UNUserNotificationCenter.current().setNotificationCategories([newsCategory])

        
        /// Requesting authentication from user
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            
            /// 1. Check to see if permission is granted
            guard granted else { return }
            /// 2. Attempt registration for remote notifications on the main thread
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    /// Testing Locally via NotificationTest.apns file
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print(deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
}

extension AppDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        // 1  
        let userInfo = response.notification.request.content.userInfo
        
        // 2
//        if
//            let aps = userInfo["aps"] as? [String: AnyObject],
//            let newsItem = NewsItem.makeNewsItem(aps) {
//            (window?.rootViewController as? UITabBarController)?.selectedIndex = 1
//
//            // 3
//            if response.actionIdentifier == Identifiers.viewAction,
//               let url = URL(string: newsItem.link) {
//                let safari = SFSafariViewController(url: url)
//                window?.rootViewController?
//                    .present(safari, animated: true, completion: nil)
//            }
//        }
        
        // 4
        completionHandler()
    }
}
