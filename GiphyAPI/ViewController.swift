//
//  ViewController.swift
//  GiphyAPI
//
//  Created by Jerry Shi on 2020-09-13.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    //MARK: IBOutlets
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    let disposeBag = DisposeBag()
    private var giphyDataViewModel: GiphyDataViewModel?
    
    static func instantiate(viewModel: GiphyDataViewModel) -> ViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateInitialViewController() as! ViewController
        viewController.giphyDataViewModel = viewModel
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupViews()
        
        giphyDataViewModel?.fetchGifViewModels()
            .observeOn(MainScheduler.instance)
            .bind(
            to: tableView.rx.items(cellIdentifier: "cell")
        ) { index, viewModel, cell in
            cell.textLabel?.text = viewModel.displayText
        }.disposed(by: disposeBag)
        
//        let service = GiphyService()
//        service.fetchGiphyData().subscribe(onNext: { (giphyResponse) in
//            print(giphyResponse)
//            }).disposed(by: disposeBag)
    }
    
    func setupViews() {
        navigationItem.title = giphyDataViewModel?.title
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.tableFooterView = UIView()
        tableView.contentInsetAdjustmentBehavior = .never
    }


}

