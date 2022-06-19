//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Serhii Kopytchuk on 19.03.2022.
//

import UIKit
import Foundation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.

        DispatchQueue.main.async {
            if UserDefaults.standard.value(forKey: "currentCity") == nil {
                UserDefaults.standard.set("London", forKey: "currentCity")
                NotificationCenter.default.post(name: .internetDown, object: nil, userInfo: nil)
            }

            if UserDefaults.standard.value(forKey: "temperatureType") == nil{
                UserDefaults.standard.set("C", forKey: "temperatureType")
                NotificationCenter.default.post(name: .internetDown, object: nil, userInfo: nil)
            }

            if UserDefaults.standard.value(forKey: "windSpeedType") == nil {
                UserDefaults.standard.set("kph", forKey: "windSpeedType")
                NotificationCenter.default.post(name: .internetDown, object: nil, userInfo: nil)
            }

            if UserDefaults.standard.value(forKey: "distanceType") == nil {
                UserDefaults.standard.set("km", forKey: "distanceType")
                NotificationCenter.default.post(name: .internetDown, object: nil, userInfo: nil)
            }
        }
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

