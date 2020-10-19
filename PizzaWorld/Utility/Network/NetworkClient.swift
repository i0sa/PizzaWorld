//
//  NetworkClient.swift
//  PizzaWorld
//
//  Created by Osama on 10/19/20.
//

import Foundation
import Alamofire

class NetworkClient {
    
    func performRequest<T: Decodable>(_ object: T.Type, router: APIRouter, completion: @escaping ((Result<ResponseObject<T>, Error>) -> Void)) {
        AF.request(router).responseJSON { (response) in
            
            do {
                let models = try JSONDecoder().decode(ResponseObject<T>.self, from: response.data!)
                completion(.success(models))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
    
    func upload<T: Decodable>(_ object: T.Type, router: APIRouter, completion: @escaping ((Result<ResponseObject<T>, Error>) -> Void)) {
        AF.upload(URL(string:"file://awdawd.png")!, with: router).responseJSON { (response) in
            #imageLiteral(resourceName: "PizzaUnSelected").jpegData(compressionQuality: 0.5)
        }
    }
}
