//
//  PizzaMakerVC.swift
//  PizzaWorld
//
//  Created by Osama on 10/20/20.
//

import UIKit

class PizzaMakerVC: BaseWireframe<PizzaMakerViewModel> {

    @IBOutlet weak var categoriesCollectionview: UICollectionView!
    
    @IBOutlet weak var categoriesItemsCollectionView: UICollectionView!
    
    @IBOutlet weak var pizzaNameLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    lazy var categoriesDataSource: CategoriesDataSource = {
        return .init(viewModel: viewModel)
    }()
    
    lazy var categoriesItemsDataSource: CategoriesItemsDataSource = {
        return .init(viewModel: viewModel)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        registerCells()
        categoriesCollectionview.dataSource = categoriesDataSource
        categoriesItemsCollectionView.dataSource = categoriesItemsDataSource
        categoriesCollectionview.delegate = self
        categoriesItemsCollectionView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    private func registerCells(){
        categoriesCollectionview.registerCell(cellClass: CategoryCell.self)
        categoriesItemsCollectionView.registerCell(cellClass: ItemCell.self)
    }
    
    override func bind(viewModel: PizzaMakerViewModel) {
        viewModel.configureWithPizzaOptionsViewModel.subscribe(onNext: { [weak self] viewModel in
            self?.configurePizzaOptions(viewModel)
        }).disposed(by: disposeBag)
        
        viewModel.configurePizzaCategories.subscribe(onNext: { [weak self] viewModel in
            self?.categoriesCollectionview.reloadData()
        }).disposed(by: disposeBag)
    
        viewModel.configurePizzaCategoriesItems.subscribe(onNext: { [weak self] viewModel in
            self?.categoriesItemsCollectionView.reloadData()
            guard self?.categoriesItemsCollectionView.numberOfItems(inSection: 0) ?? 0 > 0 else { return }
            self?.categoriesItemsCollectionView.scrollToItem(at: .init(row: 0, section: 0), at: .centeredHorizontally, animated: true)
        }).disposed(by: disposeBag)
        
        // UI Bindings
        backButton.rx.tap.subscribe(onNext: { [weak self] tap in
            self?.coordinator.dismiss()
        }).disposed(by: disposeBag)
    }
    
    private func configurePizzaOptions(_ viewModel: PizzaOptionsViewModel){
        pizzaNameLabel.text = viewModel.pizzaName
    }

}


extension PizzaMakerVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard !cell.isSelected else { return }
        
        cell.transform = .init(scaleX: 0.8, y: 0.8)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoriesCollectionview {
            print("Did Select category")
            viewModel.didPressOnCategory(indexPath: indexPath)
        } else if collectionView == categoriesItemsCollectionView {
            print("Did Select item")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoriesCollectionview {
            return .init(width: collectionView.bounds.width / 2.8, height: collectionView.bounds.height)
        } else if collectionView == categoriesItemsCollectionView {
            return .init(width: collectionView.bounds.width / 1.4, height: collectionView.bounds.height)
        }
        
        return .init(width: 0, height: 0)
    }
    
}
