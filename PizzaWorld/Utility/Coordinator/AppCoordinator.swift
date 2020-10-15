//
//  AppCoordinator.swift
//  PizzaWorld
//
//  Created by Osama on 10/15/20.
//

import Foundation
import UIKit

protocol Coordinator {
    var Main: MainNavigator { get }
    var navigationController: UINavigationController? { get }
}

class AppCoordinator: Coordinator {
    let window: UIWindow
    
    private lazy var tabBar: CustomTabBarController = {
        return CustomTabBarController(coordinator: self)
    }()
    
    lazy var Main: MainNavigator = {
        return .init(coordinator: self)
    }()
    
    var navigationController: UINavigationController? {
        if let navigationController = tabBar.selectedViewController as? UINavigationController {
            return navigationController
        }
        return nil
    }
    
    init(window: UIWindow = UIWindow()) {
        self.window = window
    }
    
    func start(){
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    var rootViewController: UIViewController {
        return tabBar
    }
}
