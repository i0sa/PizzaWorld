//
//  CartManager.swift
//  PizzaWorld
//
//  Created by Osama on 10/17/20.
//

import Foundation
import RxCocoa
import RxSwift

class CartManager {
    static var shared = CartManager()
    
    private var items: BehaviorRelay<[CartItem]> = .init(value: [])
    var itemsObservable: Observable<[CartItem]>

    init() {
        itemsObservable = items.asObservable()
    }
    
    func add(product: Product, notes: String? = nil){
        // Detect if product is found, then increase quantity
        if let productIndex = items.value.firstIndex(where: { (item) -> Bool in
            item.product.title == product.title
        }) {
            var dataCopy = items.value
            dataCopy[productIndex].product.quantity += 1
            items.accept(dataCopy)
            return
        }
        
        // Detect if product is not found, then add it
        let cartItem = convertProductToCartItem(product, notes: notes)
        var newData = items.value
        newData.append(cartItem)
        items.accept(newData)
    }
    
    var totalCost: Double {
        var totalCost: Double = 0
        for item in items.value {
            totalCost += item.product.price
        }
        
        return totalCost
    }
    
    var itemsCount: Int {
        return items.value.count
    }
    

    private func convertProductToCartItem(_ product: Product, notes: String? = nil) -> CartItem{
        return .init(product: product, notes: notes)
    }
}
