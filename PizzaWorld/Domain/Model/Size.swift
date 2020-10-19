//
//  Size.swift
//  PizzaWorld
//
//  Created by Osama on 10/17/20.
//

import Foundation

// MARK: - Size
struct Size: Decodable {
    let id: Int
    let size: String
    let slices: Int
    let price: Double
}
