//
//  ResponseObject.swift
//  PizzaWorld
//
//  Created by Osama on 10/19/20.
//

import Foundation

struct ResponseObject<T: Decodable>: Decodable {
    var message: String
    var status: Bool
    var data: T
}


struct ResponsePaginationObject<T: Decodable>: Decodable {
    var message: String
    var status: Bool
    var data: T
    var pageId: Int
}
