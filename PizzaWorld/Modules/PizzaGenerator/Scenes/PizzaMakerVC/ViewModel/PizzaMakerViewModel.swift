//
//  PizzaMakerViewModel.swift
//  PizzaWorld
//
//  Created by Osama on 10/20/20.
//

import Foundation
import RxSwift
import RxCocoa

protocol PizzaMakerViewModelInputs {
}

protocol PizzaMakerViewModelOutputs {
    var configureWithPizzaOptionsViewModel: Observable<PizzaOptionsViewModel> { get }
    var configurePizzaCategories: Observable<[PizzaCategoryViewModel]> { get }
    var configurePizzaCategoriesItems: Observable<[PizzaCategoryItemViewModel]> { get }
}

class PizzaMakerViewModel: BaseViewModel, PizzaMakerViewModelInputs, PizzaMakerViewModelOutputs {
    let options: PizzaOptions
    private var configureWithPizzaOptionsViewModelSubject: PublishSubject<PizzaOptionsViewModel> = .init()
    var configureWithPizzaOptionsViewModel: Observable<PizzaOptionsViewModel>
    
    internal var configurePizzaCategories: Observable<[PizzaCategoryViewModel]>
    var configurePizzaCategoriesSubject: PublishSubject<[PizzaCategoryViewModel]> = .init()
    var configurePizzaCategoriesItemsSubject: PublishSubject<[PizzaCategoryItemViewModel]> = .init()
    var configurePizzaCategoriesItems: Observable<[PizzaCategoryItemViewModel]>
    let disposeBag = DisposeBag()
    
    let pizzaRepository: PizzaRepository
    init(_ options: PizzaOptions,
         repository: PizzaRepository) {
        self.configurePizzaCategories = configurePizzaCategoriesSubject.asObservable()
        self.configurePizzaCategoriesItems = configurePizzaCategoriesItemsSubject.asObservable()
        self.pizzaRepository = repository
        self.options = options
        self.configureWithPizzaOptionsViewModel = configureWithPizzaOptionsViewModelSubject.asObservable()
    }
    var pizzaCateogriesViewModels: [PizzaCategoryViewModel] = []

    func viewDidLoad(){
        let pizzaOptionsViewModel = PizzaOptionsViewModel.init(options)
        configureWithPizzaOptionsViewModelSubject.onNext(pizzaOptionsViewModel)
        bind()
    }
    
    var currentSelectedCategory = 0
    
    func didPressOnCategory(indexPath: IndexPath){
        self.currentSelectedCategory = indexPath.row
        configurePizzaCategoriesItemsSubject.onNext([])
    }
    
    private func bind(){
        pizzaRepository.fetchCategories().subscribe(onNext: { [weak self] items in
            let mapped = items.map(PizzaCategoryViewModel.init)
            self?.pizzaCateogriesViewModels = mapped
            self?.configurePizzaCategoriesSubject.onNext(mapped)
            
        }).disposed(by: disposeBag)
    }
    
    func categoryViewModelForIndex(indexPath: IndexPath) -> PizzaCategoryViewModel{
        return self.pizzaCateogriesViewModels[indexPath.row]
    }

    func categoryItemViewModelForIndex(indexPath: IndexPath) -> PizzaCategoryItemViewModel{
        let model = pizzaRepository.items[currentSelectedCategory].items[indexPath.row]
        let mappedModel = PizzaCategoryItemViewModel(model)
        return mappedModel
    }

    
}
