//
//  PopularCell.swift
//  PizzaWorld
//
//  Created by Osama on 10/15/20.
//

import UIKit

class PopularCell: UITableViewCell {

    @IBOutlet weak var ratingView: RatingView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        ratingView.stackView.removeAllArrangedSubviews()
    }
}
