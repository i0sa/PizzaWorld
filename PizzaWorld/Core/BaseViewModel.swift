//
//  BaseViewModel.swift
//  PizzaWorld
//
//  Created by Osama on 10/19/20.
//

import Foundation
import RxSwift
import RxCocoa

class BaseViewModel: ViewModel {
    var isLoading: PublishSubject<Bool> = .init()
    var displayError: PublishSubject<String> = .init()
    
    
}
