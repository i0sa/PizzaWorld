//
//  QuantityView.swift
//  PizzaWorld
//
//  Created by Osama on 10/17/20.
//

import UIKit
import RxSwift
import RxCocoa

class QuantityView: NibLoadingView {
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var valueLabel: UILabel!
    private var currentValue: BehaviorRelay<Int> = .init(value: 0)
    
    lazy var currentValueObservable: Observable<Int> = {
        return currentValue.asObservable()
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup(){
        currentValueObservable.subscribe { [weak self] (quantity) in
            self?.valueLabel.text = "\(quantity.element ?? 0)"
        }.disposed(by: disposeBag)
    }
    
    @IBAction func didPressPlus(_ sender: Any) {
        currentValue.accept(currentValue.value + 1)
    }
    
    @IBAction func didPresMinus(_ sender: UIButton) {
        guard currentValue.value > 0 else { return }
        currentValue.accept(currentValue.value - 1)
    }
    
    public var value: Int {
        return currentValue.value
    }
}


