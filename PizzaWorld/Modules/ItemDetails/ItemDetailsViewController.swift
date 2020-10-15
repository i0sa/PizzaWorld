//
//  ItemDetailsViewController.swift
//  PizzaWorld
//
//  Created by Osama on 10/15/20.
//

import UIKit

class ItemDetailsViewController: BaseWireframe<ItemDetailsViewModel> {

    @IBOutlet weak var pizzaLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }

    
    override func bind(viewModel: ItemDetailsViewModel) {
        viewModel.displayMainData.subscribe { [weak self] (viewModel) in
            self?.setupProductView(with: viewModel)
        }.disposed(by: disposeBag)
    }
    
    private func setupProductView(with viewModel: ProductViewModel){
        pizzaLabel.text = viewModel.mainTitle
    }
}
