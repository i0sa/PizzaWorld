//
//  HomeUseCase.swift
//  PizzaWorld
//
//  Created by Osama on 10/20/20.
//

import Foundation
import RxSwift
import RxCocoa

class HomeUseCase {
    let homeRepository: HomeRepository
    let networkDispatchGroup = DispatchGroup()
    let disposeBag = DisposeBag()
    
    init(homeRepository: HomeRepository) {
        self.homeRepository = homeRepository
        networkDispatchGroup.notify(queue: .main) {
            print("I'm done")
        }
        self.networkDispatchGroup.enter()
        self.networkDispatchGroup.enter()
        self.networkDispatchGroup.leave()
        self.networkDispatchGroup.leave()

    }

    func executeSliderFetch() -> Observable<[Slider]>{
        let observable = homeRepository.fetchSliderData()
        observable.subscribe { [weak self] (item) in
            DispatchQueue.main.async {
//                self?.networkDispatchGroup.leave()
            }
        }.disposed(by: disposeBag)

        return observable
    }
    
    func executePopularFetch() -> Observable<[Product]> {
        let observable = homeRepository.fetchPopularData()
        observable.subscribe { [weak self] (item) in
//                self?.networkDispatchGroup.leave()
        }.disposed(by: disposeBag)
        return observable
    }
    
}
