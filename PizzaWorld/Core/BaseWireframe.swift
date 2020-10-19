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
import Toast_Swift
import RxReachability
import Reachability

protocol ViewModel {
    
}

class BaseWireframe<T: BaseViewModel>: UIViewController {
    var viewModel: T!
    var coordinator: Coordinator!

    lazy var disposeBag: DisposeBag = {
        return DisposeBag()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(viewModel: viewModel)
        bindStates()
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
    
    func bindStates(){
        viewModel.displayError.subscribe { [weak self] (text) in
            self?.displayError(text: text)
        }.disposed(by: disposeBag)
        
        viewModel.isLoading.subscribe { [weak self] (isLoading) in
            guard let isLoading = isLoading.element else { return }
            if(isLoading){
                self?.view.makeToastActivity(.center)
            } else {
                self?.view.hideToastActivity()
            }
        }.disposed(by: disposeBag)

        
        // reachability state binding
        Reachability.rx.isReachable.subscribe(onNext: { isReachable in
            if(isReachable == false){
                self.displayError(text: "No network found...")
            }
        }).disposed(by: disposeBag)
    }
}

extension BaseWireframe {
    func displayError(text: String){
        let alert = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let cancelButton = UIAlertAction.init(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
    }
}

extension BaseWireframe where T: BaseViewModel {
    func bindLoadings(){
        print("Base view model is implemneted here..")
    }
}
