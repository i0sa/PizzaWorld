//
//  PizzaOptionsView.swift
//  PizzaWorld
//
//  Created by Osama on 10/17/20.
//

import UIKit

class PizzaOptionsView: NibLoadingView {
    @IBOutlet weak var sizeView: SizesSelectorView!
    
    @IBOutlet weak var quantityView: QuantityView!
    
    @IBOutlet weak var descriptionView: PIZZATextView!
}
