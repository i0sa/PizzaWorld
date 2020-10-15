//
//  HomeViewModel.swift
//  PizzaWorld
//
//  Created by Osama on 10/14/20.
//

import Foundation
import RxSwift
import RxCocoa

protocol HomeViewModelOutput {
    var slideToItem: PublishSubject<Int> { get set }
    var navigateToItemDetails: PublishSubject<Product> { get set }
}

protocol HomeViewModelInput {
    func viewDidLoad()
    func scrollToNextItem()
    func didSelectItemAtIndexPath(_ indexPath: IndexPath)
}

class HomeViewModel: ViewModel, HomeViewModelOutput & HomeViewModelInput {
    private var sliderTimer: Timer?
    var slides: BehaviorRelay<[Int]> = .init(value: [1])
    var popularItems: BehaviorRelay<[Product]> = .init(value: [
        .init(title: "Pizza"),
        .init(title: "Pizza Burger"),
        .init(title: "Pizza Shrimp"),
        .init(title: "Pizza Beef"),
        .init(title: "Pizza BBQ")
    ])
    private var currentSlide = 0
    
    
    // outputs
    var slideToItem: PublishSubject<Int> = .init()
    var navigateToItemDetails: PublishSubject<Product> = .init()
    
    // Inputs
    func viewDidLoad(){
        sliderTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(scrollToNextItem), userInfo: nil, repeats: true)
    }
    
    @objc func scrollToNextItem(){
        let nextSlide = currentSlide + 1
        currentSlide = nextSlide % slides.value.count
        slideToItem.onNext(currentSlide)
    }
    
    func didSelectItemAtIndexPath(_ indexPath: IndexPath) {
        let model = popularItems.value[indexPath.row]
        navigateToItemDetails.onNext(model)
    }
    
    //MARK: Public Variables
    var numberOfItems: Int {
        return slides.value.count
    }
    
}
