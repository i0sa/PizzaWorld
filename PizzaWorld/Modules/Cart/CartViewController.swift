//
//  CartViewController.swift
//  PizzaWorld
//
//  Created by Osama on 10/17/20.
//

import UIKit
import RxSwift
import RxCocoa

class CartViewController: BaseWireframe<CartViewModel> {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var placeOrderButton: PizzaButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    func configureTableView(){
        registerCells()
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel.output.cartItemsObservable.bind(to: tableView.rx.items(cellIdentifier: String(describing: CartItemCell.self), cellType: CartItemCell.self)) { index, model, cell in
            cell.configure(with: model)
        }.disposed(by: disposeBag)
        
        viewModel.output.itemHeaderDidChangeObservable.subscribe { [weak self] (viewModel) in
            guard let self = self, let viewModel = viewModel.element else { return }
            self.tableView.reloadData()
        }.disposed(by: disposeBag)

        
    }
    
    func registerCells(){
        tableView.registerCellNib(cellClass: CartHeaderCell.self)
        tableView.registerCellNib(cellClass: CartItemCell.self)
        tableView.registerCellNib(cellClass: CartTotalFooterCell.self)
    }
    
    override func bind(viewModel: CartViewModel) {
        
    }

    @IBAction func didPressOnPlaceOrder(_ sender: PizzaButton) {
    }
}

extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeue() as CartHeaderCell
        if let headerViewModel = viewModel.cartHeaderViewModel {
            cell.configure(with: headerViewModel)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}
