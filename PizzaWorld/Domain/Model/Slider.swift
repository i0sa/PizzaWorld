//
//  Slider.swift
//  PizzaWorld
//
//  Created by Osama on 10/19/20.
//

import Foundation


struct Slider: Decodable {
    var id: Int
    var image: URL
    var buttonTitle: String
    var product: Product
    
    enum CodingKeys: String, CodingKey {
        case id, image, product
        case buttonTitle = "button_title"
        
    }
}
