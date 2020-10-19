//
//  MainRouter.swift
//  PizzaWorld
//
//  Created by Osama on 10/19/20.
//

import Foundation
import Alamofire

enum MainRouter: APIRouter {
    case slider
    
    var method: HTTPMethod {
        switch self {
        case .slider:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .slider:
            return "slider.php"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .slider:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .slider:
            return URLEncoding.default
        }
    }


}
