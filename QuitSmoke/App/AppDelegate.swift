//
//  AppDelegate.swift
//  QuitSmoke
//
//  Created by Павел Лахно on 25.10.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        /*

        func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        let defaults = NSUserDefaults.standardUserDefaults()
                if let launchview = defaults.stringForKey("LaunchView")
                {

                    if launchview == "ViewController1" {

                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.window = UIWindow(frame: UIScreen.mainScreen().bounds)
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let yourVC = mainStoryboard.instantiateViewControllerWithIdentifier("VC1") as! ViewController1
                appDelegate.window?.rootViewController = yourVC
                appDelegate.window?.makeKeyAndVisible()

                    } else if launchview == "ViewController2" {
                        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                        appDelegate.window = UIWindow(frame: UIScreen.mainScreen().bounds)
                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let yourVC = mainStoryboard.instantiateViewControllerWithIdentifier("VC1") as! ViewController1
                        appDelegate.window?.rootViewController = yourVC
                        appDelegate.window?.makeKeyAndVisible()
                    }

                }

                return true
           }
         */
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

