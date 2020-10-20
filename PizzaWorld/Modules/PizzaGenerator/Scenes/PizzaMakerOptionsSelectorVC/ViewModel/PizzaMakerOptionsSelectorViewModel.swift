//
//  PizzaMakerViewModel.swift
//  PizzaWorld
//
//  Created by Osama on 10/20/20.
//

import Foundation
import RxSwift
import RxCocoa

protocol PizzaMakerOptionsSelectorViewModelInputs {
    func didPressNextWithOptions(pizzaName: String?)
}

protocol PizzaMakerOptionsSelectorViewModelOutputs {
    var navigateToStepTwo: Observable<PizzaOptions> { get }
}

class PizzaMakerOptionsSelectorViewModel: BaseViewModel, PizzaMakerOptionsSelectorViewModelInputs & PizzaMakerOptionsSelectorViewModelOutputs {
    let pizzaOptions = PizzaOptions()
    
    private var navigateToStepTwoSubject: PublishSubject<PizzaOptions> = .init()
    var navigateToStepTwo: Observable<PizzaOptions>

    override init() {
        self.navigateToStepTwo = navigateToStepTwoSubject.asObservable()
    }
    
    func didPressNextWithOptions(pizzaName: String?){
        guard pizzaName?.count ?? 0 > 0 else {
            self.displayError.onNext("Please type pizza name..")
            return
        }
        self.pizzaOptions.name = pizzaName
        self.navigateToStepTwoSubject.onNext(pizzaOptions)
    }
    
}
