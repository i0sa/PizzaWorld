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
    func didDeleteItem(at indexPath: IndexPath)
}

protocol CartViewModelProtocol: CartViewModelInputs & CartViewModelOutputs {
    var input: CartViewModelInputs { get }
    var output: CartViewModelOutputs { get }
}

class CartViewModel: BaseViewModel, CartViewModelProtocol {
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
    
    override init() {
        cartItemsObservable = cartItems.asObservable()
        itemHeaderDidChangeObservable = itemHeaderDidChange.asObservable()
        super.init()
        bind()
    }
    
    var items: [CartItem] = []
    
    func bind(){
        CartManager.shared.itemsObservable.subscribe { [weak self] (items) in
            guard let items = items.element else { return }
            self?.items = items
            let mappedItems = items.map(CartItemViewModel.init)
            self?.cartHeaderViewModel = .init()
            self?.itemHeaderDidChange.onNext((self?.cartHeaderViewModel!)!)
            self?.cartItems.accept(mappedItems)
        }.disposed(by: disposeBag)
    }
    
    // inputs
    func didDeleteItem(at indexPath: IndexPath) {
        CartManager.shared.delete(product: items[indexPath.row].product)
    }
    
}
