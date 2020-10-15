//
//  Navigator.swift
//  PizzaWorld
//
//  Created by Osama on 10/15/20.
//

import Foundation
import UIKit

enum NavigatorTypes {
    case push
    case present
    case root
}

protocol Navigator {
    associatedtype Destination
    func viewController(for destination: Destination) -> UIViewController
    init(coordinator: Coordinator)
    var coordinator: Coordinator { get }
    func navigate(to destination: Destination, with navigationType: NavigatorTypes)
}

extension Navigator {
    func navigate(to destination: Destination,
                  with navigationType: NavigatorTypes = .push) {
        let viewController = self.viewController(for: destination)
        switch navigationType {
        case .push:
            coordinator.navigationController?.pushViewController(viewController, animated: true)
        case .present:
            coordinator.navigationController?.present(viewController, animated: true, completion: nil)
        case .root:
            coordinator.navigationController?.setViewControllers([viewController], animated: true)
        }
    }
}
