//
//  HomeRepository.swift
//  PizzaWorld
//
//  Created by Osama on 10/19/20.
//

import Foundation
import RxSwift
import RxCocoa

protocol PizzaRepository {
    func fetchCategories() -> Observable<[PizzaCategory]>
    var items: [PizzaCategory] { get }
    func numberOfItems(for dataType: PizzaDataType) -> Int
}

enum PizzaDataType {
    case categories
    case items(categoryIndex: Int)
}


class PizzaRepositoryImpl: PizzaRepository {
    let networkClient: NetworkClient
    
    init(networkClient: NetworkClient = NetworkClient()) {
        self.networkClient = networkClient
    }
    
    
    var items: [PizzaCategory] = []
    
    func fetchCategories() -> Observable<[PizzaCategory]> {
        Observable<[PizzaCategory]>.create { [weak self] (item) -> Disposable in
            self?.networkClient.performRequest([PizzaCategory].self, router: PizzaRouter.categories) { (result) in
                switch result {
                case .success(let data):
                    self?.items = data.data
                    item.onNext(data.data)
                    item.onCompleted()
                case .failure(let error):
                    item.onError(error)
                }
            }
            return Disposables.create()
        }
    }
        
    func numberOfItems(for dataType: PizzaDataType) -> Int{
        switch dataType{
        case .categories:
            return items.count
        case .items(let index):
            guard items.indices.contains(index) else { return 0 }
            return items[index].items.count
        }
    }
}
