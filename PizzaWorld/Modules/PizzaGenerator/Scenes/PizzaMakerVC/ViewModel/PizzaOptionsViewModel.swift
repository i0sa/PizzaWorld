//
//  PizzaOptionsViewModel.swift
//  PizzaWorld
//
//  Created by Osama on 10/20/20.
//

import Foundation

class PizzaOptionsViewModel {
    var pizzaName: String
    
    init(_ pizzaOptions: PizzaOptions) {
        self.pizzaName = pizzaOptions.name ?? ""
    }
}
