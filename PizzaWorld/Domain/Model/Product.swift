//
//  Popular.swift
//  PizzaWorld
//
//  Created by Osama on 10/15/20.
//

import Foundation

// MARK: - Product
struct Product: Decodable {
    let id: Int
    let title, productDescription: String
    let image: String
    let category, cookTime: String
    let rating: Int
    let ingredients: String
    let sizes: [Size]

    enum CodingKeys: String, CodingKey {
        case id, title
        case productDescription = "description"
        case image, category
        case cookTime = "cook_time"
        case rating, ingredients, sizes
    }
}

