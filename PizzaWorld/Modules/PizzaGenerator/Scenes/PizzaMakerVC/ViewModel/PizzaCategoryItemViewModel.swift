//
//  PizzaCategoryViewModel.swift
//  PizzaWorld
//
//  Created by Osama on 10/20/20.
//

import Foundation


class PizzaCategoryItemViewModel {
    let imageUrl: URL?
    let name: String
    
    init(_ category: PizzaItem) {
        self.imageUrl = URL(string: category.image)
        self.name = category.name
    }
}
