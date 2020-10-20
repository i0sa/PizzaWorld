//
//  PizzaCategoryViewModel.swift
//  PizzaWorld
//
//  Created by Osama on 10/20/20.
//

import Foundation


class PizzaCategoryViewModel {
    let imageUrl: URL?
    let name: String
    
    init(_ category: PizzaCategory) {
        self.imageUrl = URL(string: category.image)
        self.name = category.name
    }
}
