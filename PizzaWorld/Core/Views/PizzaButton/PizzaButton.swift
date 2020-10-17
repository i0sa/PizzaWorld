//
//  PizzaButton.swift
//  PizzaWorld
//
//  Created by Osama on 10/17/20.
//

import UIKit

class PizzaButton: UIButton {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI(){
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = 25
        self.backgroundColor = .pinkishRedTwo
        self.shadowColor = UIColor.black
        self.shadowOffset = .init(x: 0, y: 6)
        self.shadowOpacity = 0.25
        self.shadowRadius = 20
    }
}
