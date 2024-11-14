//
//  AppDelegate.swift
//  Logo
//
//  Created by Nihal kamboj on 04/03/22.
//

import UIKit
import Firebase
import FirebaseMessaging
import UserNotifications
import IQKeyboardManagerSwift
import CoreLocation

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    
    var window: UIWindow?
    var notificationContent = [AnyHashable : Any]()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        FirebaseApp.configure()
        SingleTon.shared.onRequest = false
      //  SingleTon.shared.userToken = "JWtr6nz75s"
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { _, _ in }
            )
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        
        
        print("+++++++++++++++++", SingleTon.shared.userToken)
        
        print("-=-=-=-=-=-=-=-=-=-=-=", SingleTon.shared.userToken)
        if SingleTon.shared.userToken != "" {
            executeMainHome()
        } else {
            executeLogin()
        }
        
        
        let locationManager = CLLocationManager()
            locationManager.requestAlwaysAuthorization()
            return true
        
        return true
    }
    
    //MARK: - Poseidon MainHome Controller
    func executeMainHome() {
         //let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainHome_Nav")
        let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Dashboard_Nav")
        self.window?.rootViewController = homeVC
        self.window?.makeKeyAndVisible()
    }
    
    func executeLogin() {
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login_Nav")
      //let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController")
        
        self.window?.rootViewController = loginVC
        self.window?.makeKeyAndVisible()
    }
    
    //MARK: - Poseidon Home Controller
    func executeHome() {
        let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Home_VC")
        self.window?.rootViewController = homeVC
        self.window?.makeKeyAndVisible()
    }
    
    //MARK: - WorkOrder Home Controller
    func executWorkOrderHome() {
        let homeVC = UIStoryboard(name: "WorkOrderView", bundle: nil).instantiateViewController(withIdentifier: "WorkOrderViewNav")
        self.window?.rootViewController = homeVC
        self.window?.makeKeyAndVisible()
    }
    
    
    //MARK: - Push Notifications
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                print("FCM registration token: \(token)")
                SingleTon.shared.fcmToken = token
            }
        }
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
        SingleTon.shared.fcmToken = fcmToken ?? "121"
        let dataDict: [String: String] = ["token": fcmToken ?? " "]
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict
        )
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().setAPNSToken(deviceToken, type: .unknown)
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                print("FCM registration token: \(token)")
                SingleTon.shared.fcmToken = token
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        self.notificationContent = response.notification.request.content.userInfo
        print(self.notificationContent)
        if let notificationType = notificationContent["gcm.notification.priority"] as? String
        {            if notificationType == "high"{
            print("-=-jbhhbhbnk",notificationContent["gcm.notification.data"])
            do {
                let notificationData = notificationContent["gcm.notification.data"] as! String
                let dict = try! JSONSerialization.jsonObject(with: notificationData.data(using: .utf8)!, options: []) as! [String:Any]
                print(dict)
                
                if dict["notificationType"] as! String == "schedule"{
                    SingleTon.shared.scheduleData["type"] = dict["type"]
                    SingleTon.shared.scheduleData["notes"] = dict["notes"]
                    SingleTon.shared.scheduleData["date"] = dict["date"]
                    SingleTon.shared.scheduleData["time"] = dict["time"]
                    SingleTon.shared.scheduleData["mettingId"] = dict["mettingId"]
                    SingleTon.shared.meetingId = dict["mettingId"] as! Int
                    NotificationCenter.default.post(name: Notification.Name("Schedule"), object: nil)
                }
                else{
                    SingleTon.shared.reqesedtUserId = dict["id"] as! String
                    SingleTon.shared.notificationType = true
                    SingleTon.shared.notificationType = true
                    NotificationCenter.default.post(name: Notification.Name("Accept"), object: nil)
                }
            }
            catch {
                print(error)
            }
        }
            else{
                SingleTon.shared.notificationType = false
            }
        }
        
    }
    
    
    func scheduleNotification() {
        // Create notification content
        let content = UNMutableNotificationContent()
        content.title = "New Notification"
        content.body = "This is a sample notification."
        content.sound = UNNotificationSound.default
        
        // Create actions for accept and reject buttons
        let acceptAction = UNNotificationAction(identifier: "acceptAction", title: "Accept", options: [])
        let rejectAction = UNNotificationAction(identifier: "rejectAction", title: "Reject", options: [])
        
        // Create category with actions
        let category = UNNotificationCategory(identifier: "notificationCategory", actions: [acceptAction, rejectAction], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        // Assign the category to the notification content
        content.categoryIdentifier = "notificationCategory"
        
        // Create a trigger for the notification (e.g., after 5 seconds)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // Create a request for the notification
        let request = UNNotificationRequest(identifier: "notificationIdentifier", content: content, trigger: trigger)
        
        // Schedule the notification
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
    
    
    
}
