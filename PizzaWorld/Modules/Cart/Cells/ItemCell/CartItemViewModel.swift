//
//  CartItemViewModel.swift
//  PizzaWorld
//
//  Created by Osama on 10/17/20.
//

import Foundation


class CartItemViewModel {
    let topString: String
    let notesString: String
    let price: String
    
    init(_ cartItem: CartItem) {
        let quantity = cartItem.quantity
        self.topString = "\(cartItem.product.title) x \(quantity)"
        if let notes = cartItem.notes {
            self.notesString = "Notes: \(notes)"
        } else {
            self.notesString = "Notes: No Notes"
        }
//        self.price = "\(cartItem.product.price * Double(cartItem.quantity)) EGP"
        self.price = "\(100 * Double(cartItem.quantity)) EGP"
    }
}
