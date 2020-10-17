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
    var viewModel: T!
    var coordinator: Coordinator!

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
    
    // Storyboard setup
    static func createFromStoryboard(storyboard: AppStoryboard, viewModel: T, coordinator: Coordinator) -> Self<T>{
        let view = Self.instantiate(fromAppStoryboard: storyboard) as Self<T>
        view.coordinator = coordinator
        view.viewModel = viewModel
        return view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    func bind(viewModel: T){
        fatalError("Please override bind function")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
