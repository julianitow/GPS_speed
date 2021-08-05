//
//  AppDelegate.swift
//  GPS_speed
//
//  Created by Julien Guillan on 02/08/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            let w = UIWindow(frame: UIScreen.main.bounds)
            w.rootViewController = UINavigationController(rootViewController: HomeViewController())
            w.makeKeyAndVisible()
            self.window = w
            return true
    }

}

