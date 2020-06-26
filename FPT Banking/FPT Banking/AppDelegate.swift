//
//  AppDelegate.swift
//  FPT Banking
//
//  Created by hưng hoàng on 6/16/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var storyboardName = ""
    var isLogout = false
    var token = ""
    var window: UIWindow?
    class var sharedInstance: AppDelegate {
        struct Singleton {
            static let instance = (UIApplication.shared.delegate as! AppDelegate)
        }
        return Singleton.instance
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
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
extension AppDelegate {
    func logout(message: String) {
        self.isLogout = true
        UIApplication.shared.applicationIconBadgeNumber = 0
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "change_badge"), object: nil)
        UserDefaults.standard.removeObject(forKey: "save_user_obj")
        UserDefaults.standard.removeObject(forKey: "save_type_user")
        UserDefaults.standard.removeObject(forKey: "term_of_use")
        FBKeychainService.saveToken(token: "")
        FBKeychainService.savePassword(token: "")
        FBKeychainService.saveUsername(token: "")
        FBDataCenter.sharedInstance.token = ""
        FBDataCenter.sharedInstance.userInfo = nil
    }
}
