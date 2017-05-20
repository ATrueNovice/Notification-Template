//
//  AppDelegate.swift
//  pushmynotif
//
//  Created by New on 5/19/17.
//  Copyright © 2017 HSI. All rights reserved.
//

//Import All the firebase utilities but only after installing the pod and installing the cert. Go back and watch the devslopes video for reference.


import UIKit
import Firebase
import FirebaseInstanceID
import FirebaseMessaging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        //This block registers the User for nofifications. But only for iOS 8. This is old code.
        if #available(iOS 8.0, *) {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()


        } else {

            //User this for iOS 9 or better.
            let types: UIRemoteNotificationType = [.alert, .badge, .sound]
            application.registerForRemoteNotifications(matching: types)
        }


        FIRApp.configure()
        NotificationCenter.default.addObserver(self, selector:
            #selector(self.tokenRefreshNotification(notification:)),
        name: NSNotification.Name.firInstanceIDTokenRefresh, object: nil)

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        //IMPORTANT
        //This disconnects from the Firebase server so that we do not waste bandwidth.

        FIRMessaging.messaging().disconnect()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

        connectToFireBaseMessaging()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    //EDITED CODE

    //Tells us that we have a new token and that it is working. 

    func tokenRefreshNotification(notification: NSNotification) {
        let refreshedToken =
        FIRInstanceID.instanceID().token()
        print("InstanceID TOken: \(refreshedToken)")

        connectToFireBaseMessaging()
    }

    //This function will tell us if the you are connected to firebase when printed out at the bottom.

    func connectToFireBaseMessaging() {

        FIRMessaging.messaging().connect { (error) in
            if (error != nil) {
                print("Unable to Connect \(error)")
            } else {
                print("Connected To FireBase Messaging")
            }

        }
    }

}
