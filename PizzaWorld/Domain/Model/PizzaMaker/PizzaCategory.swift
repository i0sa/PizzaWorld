//
//  Pizza.swift
//  PizzaWorld
//
//  Created by Osama on 10/20/20.
//

import Foundation
// MARK: - PizzaElement
struct PizzaCategory: Decodable {
    let id: Int
    let name: String
    let image: String
    let priority: Int
    let isMultipleSelection: Bool
    let items: [PizzaItem]

    enum CodingKeys: String, CodingKey {
        case id, name, image, priority
        case isMultipleSelection = "is_multiple_selection"
        case items
    }
}


// MARK: - Item
struct PizzaItem: Decodable {
    let name: String
    let image, overlayImage: String
    let price: Double

    enum CodingKeys: String, CodingKey {
        case name, image
        case overlayImage = "overlay_image"
        case price
    }
}
