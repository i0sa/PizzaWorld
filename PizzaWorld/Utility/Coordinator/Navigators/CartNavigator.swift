//
//  CartNavigator.swift
//  PizzaWorld
//
//  Created by Osama on 10/17/20.
//


import Foundation
import UIKit

class CartNavigator: Navigator {
    var coordinator: Coordinator
    
    private let storyboard: AppStoryboard = .Cart
    
    enum Destination {
        case cart
    }
    
    required init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func viewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .cart:
            let viewModel = CartViewModel()
            let view = CartViewController.createFromStoryboard(storyboard: .Cart, viewModel: viewModel, coordinator: coordinator)
            return view
        }
    }
}
