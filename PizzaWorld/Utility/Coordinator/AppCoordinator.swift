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
    var Cart: CartNavigator { get }
    var Pizza: PizzaNavigator { get }
    var navigationController: UINavigationController? { get }
    var tabBar: CustomTabBarController { get }
    func dismiss()
    var subCoordinator: Coordinator { get }
}

class AppCoordinator: Coordinator {
    let window: UIWindow
    
    lazy var tabBar: CustomTabBarController = {
        return CustomTabBarController(coordinator: self)
    }()
    
    lazy var Main: MainNavigator = {
        return .init(coordinator: self)
    }()

    lazy var Cart: CartNavigator = {
        return .init(coordinator: self)
    }()
    
    lazy var Pizza: PizzaNavigator = {
        return .init(coordinator: self)
    }()
    
    lazy var subCoordinator: Coordinator = {
        return AppCoordinator(window: window, isSub: true)
    }()
    
    lazy var subNavigationController = {
        return UINavigationController()
    }()

    var navigationController: UINavigationController? {
        if(isSub){
            return subNavigationController
        } else {
            if let navigationController = tabBar.selectedViewController as? UINavigationController {
                return navigationController
            }
            return nil
        }
    }
    var isSub: Bool
    
    init(window: UIWindow = UIWindow(), isSub: Bool = false) {
        self.window = window
        self.isSub = isSub
    }
    
    func start(){
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    func dismiss() {
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    var rootViewController: UIViewController {
        // debug
//        #if DEBUG
//        return Pizza.viewController(for: .pizzaMaker(options: .init(name: "Osama")), coordinator: self)
//        #endif
        return tabBar
    }
}
