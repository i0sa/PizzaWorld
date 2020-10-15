//
//  HomeViewController.swift
//  PizzaWorld
//
//  Created by Osama on 10/14/20.
//

import UIKit
import RxCocoa
import RxSwift

class HomeViewController: BaseWireframe<HomeViewModel> {
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var popularTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCells()
        setupPopularTableView()
        viewModel.viewDidLoad()
    }
    
    override func bind(viewModel: HomeViewModel) {
        viewModel.slideToItem.subscribe { [weak self] (index) in
            self?.sliderCollectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: [.centeredHorizontally, .centeredVertically], animated: true)
        }.disposed(by: disposeBag)
        
        viewModel.slides.subscribe { [weak self] (_) in
            self?.sliderCollectionView.reloadData()
        }.disposed(by: disposeBag)
        
        viewModel.navigateToItemDetails.asObservable().subscribe { [weak self] (product) in
            guard let self = self, let product = product.element else { return }
            self.coordinator.Main.navigate(to: .itemDetails(product: product))
        }.disposed(by: disposeBag)
    }
    
    func setupPopularTableView(){
        popularTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel.popularItems.asObservable()
            .bind(to: popularTableView.rx.items(cellIdentifier: String(describing: PopularCell.self), cellType: PopularCell.self)) { index, model, cell in
                cell.ratingView.configureWithRating(rating: 5, style: .compact)
        }.disposed(by: disposeBag)
                
        popularTableView.rx.itemSelected.subscribe { [weak self] (indexPath) in
            guard let self = self, let indexPath = indexPath.element else { return }
            self.viewModel.didSelectItemAtIndexPath(indexPath)
        }.disposed(by: disposeBag)
        
    }
    
    private func setupUI(){
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
    }
    
    func registerCells(){
        sliderCollectionView.registerCell(cellClass: SliderCell.self)
        popularTableView.registerCellNib(cellClass: PopularCell.self)
    }
}

//MARK: Slider Data Source
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(indexPath: indexPath) as SliderCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}

