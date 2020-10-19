//
//  ItemDetailsViewController.swift
//  PizzaWorld
//
//  Created by Osama on 10/15/20.
//

import UIKit

class ItemDetailsViewController: BaseWireframe<ItemDetailsViewModel> {

    @IBOutlet weak var pizzaLabel: UILabel!
    
    @IBOutlet weak var pizzaIngrients: UILabel!
    @IBOutlet weak var ratingView: RatingView!
    
    @IBOutlet weak var pizzaOptionsView: PizzaOptionsView!
    @IBOutlet weak var addToCartButton: PizzaButton!
    @IBOutlet weak var descTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }

    
    override func bind(viewModel: ItemDetailsViewModel) {
        viewModel.displayMainData.subscribe { [weak self] (viewModel) in
            self?.setupProductView(with: viewModel)
        }.disposed(by: disposeBag)
        
        
//        pizzaOptionsView.quantityView.currentValueObservable.subscribe { (quantity) in
//
//        }.disposed(by: disposeBag)
    }
    
    private func setupProductView(with viewModel: ProductViewModel){
        pizzaLabel.text = viewModel.mainTitle
        ratingView.configureWithRating(rating: viewModel.rating)
    }
    
    @IBAction func didPressAddToCart(_ sender: PizzaButton) {
        let quantity = pizzaOptionsView.quantityView.value
        viewModel.didPressAddToCart(quantity: quantity)
    }
    
}
