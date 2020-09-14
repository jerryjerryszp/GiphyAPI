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
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
