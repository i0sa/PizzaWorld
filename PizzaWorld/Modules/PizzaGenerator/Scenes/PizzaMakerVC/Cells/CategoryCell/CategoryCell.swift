//
//  CategoryCell.swift
//  PizzaWorld
//
//  Created by Osama on 10/20/20.
//

import UIKit
import Kingfisher

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isSelected = false
        overlayView.isHidden = false
        // Initialization code
    }
    
    func configure(with viewModel: PizzaCategoryViewModel){
        self.lbl.text = viewModel.name
        if let imageUrl = viewModel.imageUrl {
            img.kf.setImage(with: imageUrl)
        }
    }
    
    
    override var isSelected: Bool{
        didSet {
            if isSelected {
                self.transform = .init(scaleX: 1, y: 1)
                overlayView.isHidden = true
            } else {
                self.transform = .init(scaleX: 0.8, y: 0.8)
                overlayView.isHidden = false
            }
        }
    }
}
