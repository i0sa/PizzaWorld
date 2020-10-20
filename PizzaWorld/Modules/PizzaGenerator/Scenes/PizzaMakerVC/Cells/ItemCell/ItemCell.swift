//
//  ItemCell.swift
//  PizzaWorld
//
//  Created by Osama on 10/20/20.
//

import UIKit
import Kingfisher

class ItemCell: UICollectionViewCell {

    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    
    
    func configure(with viewModel: PizzaCategoryItemViewModel){
        self.categoryName.text = viewModel.name
        if let imageUrl = viewModel.imageUrl {
            img.kf.setImage(with: imageUrl)
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
