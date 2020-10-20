//
//  CustomTabBarController.swift
//  PizzaWorld
//
//  Created by Osama on 10/15/20.
//

import UIKit

class CustomTabBarController: UITabBarController {
    var coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum TabBarItems: Int, CaseIterable {
        case Home
        case PizzaMaker
        case Cart
    }
    
    lazy var middleButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "PizzaTabBar"), for: .normal)
        button.backgroundColor = .pinkishRed
        button.layer.cornerRadius = 30
        button.imageEdgeInsets = .init(top: 0, left: 2, bottom: 0, right: 0)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setValue(CustomTabBar(), forKey: "tabBar")
        setupTabBarItems()
        setupTabBarUI()
        createMiddleButton()
    }
    
    private func createMiddleButton() {
        self.tabBar.addSubview(middleButton)
        middleButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            middleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            middleButton.widthAnchor.constraint(equalToConstant: 60),
            middleButton.heightAnchor.constraint(equalToConstant: 60),
            middleButton.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -16)
        ])
    }
    
    func setupTabBarUI(){
        tabBar.tintColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        tabBar.unselectedItemTintColor = .red
        tabBar.items?[TabBarItems.PizzaMaker.rawValue].isEnabled = false
        middleButton.addTarget(self, action: #selector(didPressMiddleButton), for: .touchUpInside)
    }
    
    private func setupTabBarItems(){
        self.viewControllers = TabBarItems.allCases.map({
            let view = viewControllerForTabBarItem($0)
            let navigation = UINavigationController(rootViewController: view)
            return navigation
        })
    }
    
    @objc func didPressMiddleButton(){
        print("Pressed Middle Button")
//        coordinator.Pizza.navigate(to: .pizzaMakerOptions, with: .presentWithNavigation)
        // add pizza generator impl
        selectedIndex = TabBarItems.PizzaMaker.rawValue
    }
    
    func viewControllerForTabBarItem(_ item: TabBarItems) -> UIViewController{
        switch item {
        case .Home:
            let view = coordinator.Main.viewController(for: .home, coordinator: coordinator)
            view.tabBarItem = tabBarItem(for: item)
            return view
        case .PizzaMaker:
            let view = coordinator.Pizza.viewController(for: .pizzaMakerOptions, coordinator: coordinator)
//            let view = UIViewController()
            return view
        case .Cart:
            let view = coordinator.Cart.viewController(for: .cart, coordinator: coordinator)
            view.tabBarItem = tabBarItem(for: item)
            return view
        }
    }
    
    private func tabBarItem(for item: TabBarItems) -> UITabBarItem?{
        let tabBarItem: UITabBarItem
        switch item {
        case .Home:
            tabBarItem = .init(title: "Home", image: #imageLiteral(resourceName: "group4"), selectedImage: #imageLiteral(resourceName: "group4"))
        case .PizzaMaker:
            return nil
        case .Cart:
            tabBarItem = .init(title: "Cart", image: #imageLiteral(resourceName: "cart"), selectedImage: #imageLiteral(resourceName: "cart"))
        }
        tabBarItem.titlePositionAdjustment = .init(horizontal: 0, vertical: 15)
        tabBarItem.imageInsets = .init(top: 10, left: 0, bottom: -10, right: 0)
        
        return tabBarItem
    }

}
