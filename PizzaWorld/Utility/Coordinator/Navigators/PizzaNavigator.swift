//
//  CartNavigator.swift
//  PizzaWorld
//
//  Created by Osama on 10/17/20.
//


import Foundation
import UIKit

class PizzaNavigator: Navigator {
    var coordinator: Coordinator
        
    enum Destination {
        case pizzaMakerOptions
        case pizzaMaker(options: PizzaOptions)
    }
    
    required init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func viewController(for destination: Destination, coordinator: Coordinator) -> UIViewController {
        switch destination {
        case .pizzaMakerOptions:
            let viewModel = PizzaMakerOptionsSelectorViewModel()
            let view = PizzaMakerOptionsSelectorVC(viewModel: viewModel, coordinator: coordinator)
            return view
        case .pizzaMaker(let options):
            let repo = PizzaRepositoryImpl()
            let viewModel = PizzaMakerViewModel(options, repository: repo)
            let view = PizzaMakerVC(viewModel: viewModel, coordinator: coordinator)
            return view
        }
    }
}
