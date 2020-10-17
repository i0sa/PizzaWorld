//
//  ProductViewModel.swift
//  PizzaWorld
//
//  Created by Osama on 10/15/20.
//

import Foundation


class ProductViewModel {
    let mainTitle: String
    let rating: Int
    
    init(_ product: Product) {
        self.mainTitle = product.title
        self.rating = product.rating
    }
}
