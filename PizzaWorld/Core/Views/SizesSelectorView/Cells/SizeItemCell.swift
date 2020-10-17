//
//  SizeItemCell.swift
//  PizzaWorld
//
//  Created by Osama on 10/17/20.
//

import UIKit

class SizeItemCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var checkMarkView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    private let unSelectedColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    private let selectedColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)

    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCellAsUnSelected()
    }
    
    func configure(_ viewModel: SizeItemCellViewModel){
        mainLabel.text = viewModel.topString
    }

    func setCellAsUnSelected(){
        containerView.layer.borderColor = unSelectedColor.cgColor
        checkMarkView.isHidden = true
        img.image = #imageLiteral(resourceName: "PizzaUnSelected")
        mainLabel.textColor = unSelectedColor
        descLabel.textColor = unSelectedColor
        priceLabel.textColor = unSelectedColor
    }
    
    func setCellSelected(){
        containerView.layer.borderColor = selectedColor.cgColor
        checkMarkView.isHidden = false
        img.image = #imageLiteral(resourceName: "PizzaSelected")
        mainLabel.textColor = selectedColor
        descLabel.textColor = selectedColor
        priceLabel.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    }
    
    override var isSelected: Bool {
        didSet {
            if(isSelected){
                setCellSelected()
            } else {
                setCellAsUnSelected()
            }
        }
    }
}
