//
//  AppCoordinator.swift
//  GiphyAPI
//
//  Created by Jerry Shi on 2020-09-13.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import UIKit

class AppCoordinator {
    
    private var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    
    func start() {
        let viewController = ViewController.instantiate(viewModel: GiphyDataViewModel())
        let favoritesViewController = FavoritesViewController.instantiate(viewModel: FavoriteGifsViewModel())
        
        let navigationControllerOne = UINavigationController(rootViewController: viewController)
        let navigationControllerTwo = UINavigationController()
        navigationControllerTwo.viewControllers = [favoritesViewController]
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [navigationControllerOne, navigationControllerTwo]
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
