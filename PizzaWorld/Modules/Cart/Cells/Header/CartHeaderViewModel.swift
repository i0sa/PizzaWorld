//
//  CartHeaderViewModel.swift
//  PizzaWorld
//
//  Created by Osama on 10/17/20.
//

import Foundation

class CartHeaderViewModel {
    let itemsCount: String
    let totalCost: String
    
    init() {
        let count = CartManager.shared.itemsCount
        if count == 1 {
            self.itemsCount = "\(count) Item"
        } else {
            self.itemsCount = "\(count) Items"
        }
        self.totalCost = "$\(CartManager.shared.totalCost)"
    }
}
