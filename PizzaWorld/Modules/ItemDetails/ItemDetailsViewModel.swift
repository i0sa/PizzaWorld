//
//  ItemDetailsViewModel.swift
//  PizzaWorld
//
//  Created by Osama on 10/15/20.
//

import Foundation
import RxSwift
import RxCocoa

protocol ItemDetailsViewModelOutput {
    var displayMainData: PublishSubject<ProductViewModel> { get }
}

protocol ItemDetailsViewModelInput {
    func viewDidLoad()
}

class ItemDetailsViewModel: ViewModel, ItemDetailsViewModelOutput & ItemDetailsViewModelInput {
    let product: Product
    
    init(product: Product) {
        self.product = product
    }

    // outputs
    var displayMainData: PublishSubject<ProductViewModel> = .init()
    
    // inputs
    func viewDidLoad() {
        let productViewModel = ProductViewModel(product)
        displayMainData.onNext(productViewModel)
    }
}
