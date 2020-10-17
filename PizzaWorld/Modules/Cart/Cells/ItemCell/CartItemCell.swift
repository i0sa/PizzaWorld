//
//  CartItemCell.swift
//  PizzaWorld
//
//  Created by Osama on 10/17/20.
//

import UIKit

class CartItemCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with viewModel: CartItemViewModel){
        self.itemLabel.text = viewModel.topString
        self.notesLabel.text = viewModel.notesString
        self.priceLabel.text = viewModel.price
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
