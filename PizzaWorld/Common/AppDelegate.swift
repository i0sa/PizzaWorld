//
//  AppDelegate.swift
//  PizzaWorld
//
//  Created by Osama on 10/14/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        
        window?.rootViewController = HomeViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

