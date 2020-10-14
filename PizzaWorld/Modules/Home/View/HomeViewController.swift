//
//  HomeViewController.swift
//  PizzaWorld
//
//  Created by Osama on 10/14/20.
//

import UIKit
import RxCocoa
import RxSwift

class HomeViewController: UIViewController {
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    
    let viewModel = HomeViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCells()
        bind()
        viewModel.viewDidLoad()
    }
    
    func bind(){
        viewModel.slideToItem.subscribe { [weak self] (index) in
            self?.sliderCollectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: [.centeredHorizontally, .centeredVertically], animated: true)
        }.disposed(by: disposeBag)
        
        viewModel.slides.subscribe { [weak self] (_) in
            self?.sliderCollectionView.reloadData()
        }.disposed(by: disposeBag)
    }
    
    private func setupUI(){
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
    }
    
    func registerCells(){
        sliderCollectionView.registerCell(cellClass: SliderCell.self)
    }
    
    init() {
        super.init(nibName: "HomeViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Slider Data Source
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem()
    }
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

