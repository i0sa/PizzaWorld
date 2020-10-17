//
//  SizesSelectorView.swift
//  PizzaWorld
//
//  Created by Osama on 10/17/20.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class SizesSelectorView: NibLoadingView, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    let disposeBag = DisposeBag()
    let viewModel: SizesSelectorViewModel = .init()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCollection()
        registerCells()
    }
    
    func registerCells(){
        collectionView.registerCell(cellClass: SizeItemCell.self)
    }
    
    func setupCollection(){
        collectionView.allowsMultipleSelection = false
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel.output.itemsObservable
            .bind(to: collectionView.rx.items(cellIdentifier: String(describing: SizeItemCell.self), cellType: SizeItemCell.self)) { index, model, cell in
                cell.configure(model)
        }.disposed(by: disposeBag)
    }
}

extension SizesSelectorView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width / CGFloat(viewModel.numberOfItems)
        return CGSize(width: width, height: collectionView.bounds.size.height)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
}
