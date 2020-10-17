//
//  CartHeaderCell.swift
//  PizzaWorld
//
//  Created by Osama on 10/17/20.
//

import UIKit

class CartHeaderCell: UITableViewCell {
    @IBOutlet weak var itemsCountLabel: UILabel!
    @IBOutlet weak var totalCostLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with viewModel: CartHeaderViewModel){
        self.itemsCountLabel.text = viewModel.itemsCount
        self.totalCostLabel.text = viewModel.totalCost
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
