//
//  BaseWireframe.swift
//  PizzaWorld
//
//  Created by Osama on 10/15/20.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

protocol ViewModel {
    
}

class BaseWireframe<T: ViewModel>: UIViewController {
    let viewModel: T
    var coordinator: Coordinator

    lazy var disposeBag: DisposeBag = {
        return DisposeBag()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(viewModel: viewModel)
    }
    
    init(viewModel: T, coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    func bind(viewModel: T){
        fatalError("Please override bind function")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
