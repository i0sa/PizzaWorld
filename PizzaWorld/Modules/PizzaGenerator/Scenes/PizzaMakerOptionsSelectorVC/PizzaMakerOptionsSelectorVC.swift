//
//  PizzaMakerOptionsSelectorVC.swift
//  PizzaWorld
//
//  Created by Osama on 10/20/20.
//

import UIKit
import RxCocoa
import RxSwift

class PizzaMakerOptionsSelectorVC: BaseWireframe<PizzaMakerOptionsSelectorViewModel> {
    @IBOutlet weak var optionsView: PizzaOptionsView!
    @IBOutlet weak var pizzaNameField: UITextField!
    
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func bind(viewModel: PizzaMakerOptionsSelectorViewModel) {
        // UI Bindings
        backButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.coordinator.dismiss()
        }).disposed(by: disposeBag)
        
        // Viewmodel bindings
        
        viewModel.navigateToStepTwo.subscribe(onNext: { [weak self] pizzaOptions in
            self?.coordinator.Pizza.navigate(to: .pizzaMaker(options: pizzaOptions))
        }).disposed(by: disposeBag)
    }

    @IBAction func didPressNextStep(_ sender: PizzaButton) {
        let pizzaName = pizzaNameField.text
        viewModel.didPressNextWithOptions(pizzaName: pizzaName)
    }
}
