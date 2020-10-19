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
    
    func add(product: Product, quantity: Int = 1, notes: String? = nil){
        // Detect if product is found, then increase quantity
        if let productIndex = items.value.firstIndex(where: { (item) -> Bool in
            item.product.title == product.title
        }) {
            var dataCopy = items.value
            dataCopy[productIndex].quantity += quantity
            items.accept(dataCopy)
            return
        }
        
        // Detect if product is not found, then add it
        var cartItem = convertProductToCartItem(product, notes: notes)
        cartItem.quantity = quantity
        var newData = items.value
        newData.append(cartItem)
        items.accept(newData)
    }
    
    func delete(product: Product){
        // Detect if product is found, then increase quantity
        if let productIndex = items.value.firstIndex(where: { (item) -> Bool in
            item.product.title == product.title
        }) {
            var dataCopy = items.value
            dataCopy.remove(at: productIndex)
            items.accept(dataCopy)
            return
        }
    }
    
    var totalCost: Double {
        var totalCost: Double = 0
        for item in items.value {
            //            totalCost += item.product.price * Double(item.quantity)
            totalCost += 10 * Double(item.quantity)
        }
        
        return totalCost
    }
    
    var itemsCount: Int {
        var itemsCount: Int = 0
        for item in items.value {
            itemsCount += item.quantity
        }
        
        return itemsCount

    }
    

    private func convertProductToCartItem(_ product: Product, notes: String? = nil) -> CartItem{
        return .init(product: product, notes: notes)
    }
}
