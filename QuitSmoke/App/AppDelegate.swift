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
        struct JobCategory: Codable {
            let id: Int
            let name: String
        }

        // To store in UserDefaults
        if let encoded = try? JSONEncoder().encode(category) {
            UserDefaults.standard.set(encoded, forKey: UserDefaultsKeys.jobCategory.rawValue)
        }

        // Retrieve from UserDefaults
        if let data = UserDefaults.standard.object(forKey: UserDefaultsKeys.jobCategory.rawValue) as? Data,
           let category = try? JSONDecoder().decode(JobCategory.self, from: data) {
             print(category.name)
        }
         */
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }


}

