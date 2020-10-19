//
//  SizeItemCellViewModel.swift
//  PizzaWorld
//
//  Created by Osama on 10/17/20.
//

import Foundation


struct SizeItemCellViewModel {
    var topString: String
    
    init(size: Size, showPrice: Bool) {
        self.topString = size.size
    }
}
