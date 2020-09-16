//
//  FavoritesViewController.swift
//  GiphyAPI
//
//  Created by Jerry Shi on 2020-09-16.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Kingfisher
import SwiftGifOrigin

class FavoritesViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    // MARK: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Properties
    let disposeBag = DisposeBag()
    private var favoriteGifsViewModel: FavoriteGifsViewModel?
    
    // MARK: Lifecycle
    static func instantiate(viewModel: FavoriteGifsViewModel) -> FavoritesViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let favoritesViewController = storyboard.instantiateViewController(identifier: "FavoritesViewController") as! FavoritesViewController
        favoritesViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        favoritesViewController.favoriteGifsViewModel = viewModel
        return favoritesViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupViews()
        showFavoriteGifs()
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        showFavoriteGifs()
    }
    
    // MARK: Helpers
    func setupViews() {
        navigationItem.title = favoriteGifsViewModel?.favoritesTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        collectionView.register(
            UINib(nibName: String(describing: FavoritesCollectionViewCell.self), bundle: nil),
            forCellWithReuseIdentifier: String(describing: FavoritesCollectionViewCell.self)
        )
    }
    
    func showFavoriteGifs() {
        favoriteGifsViewModel?.fetchFavoriteGifViewModels()
            .observeOn(MainScheduler.instance)
            .bind(to: collectionView.rx.items(
                cellIdentifier: "FavoritesCollectionViewCell",
                cellType: FavoritesCollectionViewCell.self
            )) { row, viewModel, cell in
                guard let gifData = viewModel.gifData else {
                    return
                }
                
                cell.gifImageView.image = UIImage.gif(data: gifData)
                cell.unfavoriteButton.setTitle(viewModel.buttonTitle, for: .normal)
        }.disposed(by: disposeBag)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       let width = collectionView.bounds.width
       let cellWidthAndHeight = (width - 30) / 2
        return CGSize(width: cellWidthAndHeight, height: cellWidthAndHeight)
   }
}
