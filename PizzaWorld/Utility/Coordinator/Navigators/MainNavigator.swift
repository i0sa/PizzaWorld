//
//  MainNavigator.swift
//  PizzaWorld
//
//  Created by Osama on 10/15/20.
//

import Foundation
import UIKit

class MainNavigator: Navigator {
    var coordinator: Coordinator
    
    enum Destination {
        case home
        case itemDetails(product: Product)
    }
    
    required init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func viewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .home:
            let homeRepo = HomeRepositoryImpl()
            let viewModel = HomeViewModel(homeRepository: homeRepo)
            let view = HomeViewController(viewModel: viewModel, coordinator: coordinator)
            return view
        case .itemDetails(let product):
            let viewModel = ItemDetailsViewModel(product: product)
            let view = ItemDetailsViewController(viewModel: viewModel, coordinator: coordinator)
            return view
        }
    }
}
