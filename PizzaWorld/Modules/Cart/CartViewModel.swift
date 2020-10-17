//
//  CartViewModel.swift
//  PizzaWorld
//
//  Created by Osama on 10/17/20.
//

import Foundation
import RxSwift
import RxCocoa

protocol CartViewModelInputs {
    
}

protocol CartViewModelOutputs {
    var cartItemsObservable: Observable<[CartItemViewModel]> { get }
    var itemHeaderDidChangeObservable: Observable<CartHeaderViewModel> { get }
}

protocol CartViewModelProtocol: ViewModel, CartViewModelInputs & CartViewModelOutputs {
    var input: CartViewModelInputs { get }
    var output: CartViewModelOutputs { get }
}

class CartViewModel: CartViewModelProtocol {
    private var cartItems: BehaviorRelay<[CartItemViewModel]> = .init(value: [])
    
    let disposeBag = DisposeBag()
    
    var itemHeaderDidChange: PublishSubject<CartHeaderViewModel> = .init()
    var itemHeaderDidChangeObservable: Observable<CartHeaderViewModel>
    
    var cartHeaderViewModel: CartHeaderViewModel?

    var input: CartViewModelInputs {
        return self
    }
    var output: CartViewModelOutputs {
        return self
    }

    // outputs
    var cartItemsObservable: Observable<[CartItemViewModel]>
    init() {
        cartItemsObservable = cartItems.asObservable()
        itemHeaderDidChangeObservable = itemHeaderDidChange.asObservable()
        bind()
    }
    
    func bind(){
        CartManager.shared.itemsObservable.subscribe { [weak self] (items) in
            guard let items = items.element else { return }
            let mappedItems = items.map(CartItemViewModel.init)
            self?.cartHeaderViewModel = .init()
            self?.itemHeaderDidChange.onNext((self?.cartHeaderViewModel!)!)
            self?.cartItems.accept(mappedItems)
        }.disposed(by: disposeBag)
    }
    
}
