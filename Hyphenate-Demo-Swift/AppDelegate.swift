//
//  AppDelegate.swift
//  Hyphenate-Demo-Swift
//
//  Created by dujiepeng on 2017/6/12.
//  Copyright © 2017 dujiepeng. All rights reserved.
//

import UIKit
import Hyphenate
import UserNotifications
import XCGLogger

let xcgLogger = XCGLogger.default

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, EMClientDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UITabBar.appearance().tintColor = KermitGreenTwoColor
        UINavigationBar.appearance().tintColor = AlmostBlackColor
        
        let options = EMOptions.init(appkey: "1501170808009032#bizcardapp")
        
//        var apnsCerName = ""     
//        #if DEBUG
//            apnsCerName = "DevelopmentCertificate"     
//        #else
//            apnsCerName = "ProductionCertificate"     
//        #endif
        
        options?.apnsCertName = "BizcardDevCert"
        options?.enableConsoleLog = true     
        options?.isDeleteMessagesWhenExitGroup = false     
        options?.isDeleteMessagesWhenExitChatRoom = false     
        options?.usingHttpsOnly = true     
        
        EMClient.shared().initializeSDK(with: options)     
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(loginStateChange(nofi:)),
                                               name: NSNotification.Name(rawValue:KNOTIFICATION_LOGINCHANGE),
                                               object: nil)
        
        let storyboard = UIStoryboard.init(name: "Launch", bundle: nil)     
        let launchVC = storyboard.instantiateViewController(withIdentifier: "EMLaunchViewController")     
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = launchVC
        window?.makeKeyAndVisible()
        
        parseApplication(application, didFinishLaunchingWithOptions: launchOptions)
        _registerAPNS()
                
        return true
    }
 
    
    func loginStateChange(nofi: NSNotification) {
        if (nofi.object as! NSNumber).boolValue {
            let mainVC = EMMainViewController()     
            let nav = UINavigationController.init(rootViewController: mainVC)     
            window?.rootViewController = nav
        } else {
            let storyboard = UIStoryboard.init(name: "Register&Login", bundle: nil)     
            window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "EMLoginViewController")     
        }
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        EMClient.shared().applicationDidEnterBackground(application)     
    }

    func applicationWillEnterForeground(_ application: UIApplication) {        
        EMClient.shared().applicationWillEnterForeground(application)
    }
 
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print("didRegisterForRemoteNotificationsWithDeviceToken: \(deviceTokenString)")
        
        //Synchronization method will block the current thread
        //EMClient.shared().bindDeviceToken(deviceToken)
        
        EMClient.shared().registerForRemoteNotifications(withDeviceToken: deviceToken) { aError in
            if let aError = aError {
                print("didRegisterForRemoteNotificationsWithDeviceToken error: \(aError.errorDescription)")
            }
        }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("didFailToRegisterForRemoteNotificationsWithError \(error)")
    }
    
    fileprivate func _registerAPNS() {
        let application = UIApplication.shared     
        application.applicationIconBadgeNumber = 0     
        
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()     
            center.delegate = self      
            center.requestAuthorization(options: [.alert, .sound, .badge]) {
                (granted, error) in
                if granted {
                    application.registerForRemoteNotifications()     
                }
            }

        }
        else if #available(iOS 8.0, *) {
            let settings = UIUserNotificationSettings.init(types: [.badge, .sound, .alert], categories: nil)     
            application .registerUserNotificationSettings(settings)     
        }
    }
}

