//
//  PizzaRouter.swift
//  PizzaWorld
//
//  Created by Osama on 10/19/20.
//

import Foundation
import Alamofire

enum PizzaRouter: APIRouter {
    case categories
    
    var method: HTTPMethod {
        switch self {
        case .categories:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .categories:
            return "makercategories.php"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .categories:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .categories:
            return URLEncoding.default
        }
    }


}

