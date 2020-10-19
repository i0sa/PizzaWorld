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
    func sliderViewModelAtIndexPath(_ indexPath: IndexPath) -> SliderViewModel
}

protocol HomeViewModelInput {
    func viewDidLoad()
    func scrollToNextItem()
    func didSelectItemAtIndexPath(_ indexPath: IndexPath)
}

class HomeViewModel: BaseViewModel, HomeViewModelOutput & HomeViewModelInput {
    private var sliderTimer: Timer?
    var slides: BehaviorRelay<[SliderViewModel]> = .init(value: [])
    let disposeBag = DisposeBag()
    
    var popularItems: BehaviorRelay<[ProductViewModel]> = .init(value: [])
    
    private var currentSlide = 0
    let homeRepository: HomeRepository
    
    init(homeRepository: HomeRepository) {
        self.homeRepository = homeRepository
    }
    
    // outputs
    var slideToItem: PublishSubject<Int> = .init()
    var navigateToItemDetails: PublishSubject<Product> = .init()
    
    // Inputs
    func viewDidLoad(){
        sliderTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(scrollToNextItem), userInfo: nil, repeats: true)
        fetchSliderData()
        fetchPopularData()
    }
    
    @objc func scrollToNextItem(){
        guard slides.value.count > 0 else { return }
        let nextSlide = currentSlide + 1
        currentSlide = nextSlide % slides.value.count
        slideToItem.onNext(currentSlide)
    }
    
    func didSelectItemAtIndexPath(_ indexPath: IndexPath) {
        let model = popularItems.value[indexPath.row]
//        navigateToItemDetails.onNext(model)
    }
    
    //MARK: Public Variables
    var numberOfItems: Int {
        return slides.value.count
    }
    
    
    // Network Calls
    private func fetchSliderData(){
        isLoading.onNext(true)
        homeRepository.fetchSliderData().subscribe { [weak self] (items) in
            self?.isLoading.onNext(false)
//            self?.displayError.onNext("No network connection, please try again.")
            self?.slides.accept(items.map(SliderViewModel.init))
        } onError: { (error) in
            self.isLoading.onNext(false)
            print("I got error.. \(error)")
        } onCompleted: {
            self.isLoading.onNext(false)
            //
        }.disposed(by: disposeBag)

    }
    
    private func fetchPopularData(){
        isLoading.onNext(true)
        homeRepository.fetchPopularData().subscribe { (items) in
            self.isLoading.onNext(false)
            let slidesModels = items
            self.popularItems.accept(slidesModels.map(ProductViewModel.init))
        } onError: { (error) in
            self.isLoading.onNext(false)
            print("I got error.. \(error)")
        } onCompleted: {
            self.isLoading.onNext(false)
            //
        }.disposed(by: disposeBag)
    }
    
    func sliderViewModelAtIndexPath(_ indexPath: IndexPath) -> SliderViewModel{
        return slides.value[indexPath.row]
    }
    
}
