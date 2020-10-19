//
//  HomeRepository.swift
//  PizzaWorld
//
//  Created by Osama on 10/19/20.
//

import Foundation
import RxSwift
import RxCocoa

protocol HomeRepository {
    func fetchSliderData() -> Observable<[Slider]>
    func fetchPopularData() -> Observable<[Product]>

}

class HomeRepositoryImpl: HomeRepository {
    let networkClient: NetworkClient
    
    init(networkClient: NetworkClient = NetworkClient()) {
        self.networkClient = networkClient
    }
    
    func fetchSliderData() -> Observable<[Slider]> {
        Observable<[Slider]>.create { [weak self] (item) -> Disposable in
            self?.networkClient.performRequest([Slider].self, router: MainRouter.slider) { (result) in
                switch result {
                case .success(let data):
                    item.onNext(data.data)
                    item.onCompleted()
                case .failure(let error):
                    item.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func fetchPopularData() -> Observable<[Product]> {
        Observable<[Product]>.create { [weak self] (item) -> Disposable in
            self?.networkClient.performRequest([Product].self, router: FeedRouter.popular) { (result) in
                switch result {
                case .success(let data):
                    item.onNext(data.data)
                    item.onCompleted()
                case .failure(let error):
                    item.onError(error)
                }
            }
            return Disposables.create()
        }

    }
}
