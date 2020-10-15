//
//  ProductViewModel.swift
//  PizzaWorld
//
//  Created by Osama on 10/15/20.
//

import Foundation


class ProductViewModel {
    let mainTitle: String
    
    init(_ product: Product) {
        self.mainTitle = "Product Title: \(product.title)"
    }
}
