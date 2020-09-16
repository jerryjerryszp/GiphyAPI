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

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    
    
    
    
    // MARK: Properties
    let disposeBag = DisposeBag()
    private var giphyDataViewModel: GiphyDataViewModel?
    
    // MARK: Lifecycle
    static func instantiate(viewModel: GiphyDataViewModel) -> FavoritesViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let favoritesViewController = storyboard.instantiateViewController(identifier: "FavoritesViewController") as! FavoritesViewController
        favoritesViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        favoritesViewController.giphyDataViewModel = viewModel
        return favoritesViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupViews()
    }
    
    // MARK: Helpers
    /**
     Sets up favorites collection view
     */
    func setupCollectionView() {
        collectionView.register(
            UINib(nibName: String(describing: FavoritesCollectionViewCell.self), bundle: nil),
            forCellWithReuseIdentifier: String(describing: FavoritesCollectionViewCell.self)
        )
    }
    
    func setupViews() {
        navigationItem.title = giphyDataViewModel?.favoritesTitle
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
