//
//  CategoriesDataSource.swift
//  PizzaWorld
//
//  Created by Osama on 10/20/20.
//

import UIKit


class CategoriesItemsDataSource: NSObject, UICollectionViewDataSource {
    let viewModel: PizzaMakerViewModel
    init(viewModel: PizzaMakerViewModel) {
        self.viewModel = viewModel
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(indexPath: indexPath) as ItemCell
        let model = viewModel.categoryItemViewModelForIndex(indexPath: indexPath)
        cell.configure(with: model)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.pizzaRepository.numberOfItems(for: .items(categoryIndex: viewModel.currentSelectedCategory))
    }
}
