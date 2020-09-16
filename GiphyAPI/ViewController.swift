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
import Kingfisher

class ViewController: UIViewController {
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: Properties
    let disposeBag = DisposeBag()
    private var giphyDataViewModel: GiphyDataViewModel?
    
    // MARK: Lifecycle
    static func instantiate(viewModel: GiphyDataViewModel) -> ViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateInitialViewController() as! ViewController
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        viewController.giphyDataViewModel = viewModel
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupViews()
//        showTrendingGifs()
        searchGifs()
    }
    
    func setupViews() {
        navigationItem.title = giphyDataViewModel?.title
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.register(UINib(nibName: String(describing: HomeTableViewCell.self), bundle: nil),
                                      forCellReuseIdentifier: String(describing: HomeTableViewCell.self))
        tableView.tableFooterView = UIView()
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
    }

    func showTrendingGifs() {
        giphyDataViewModel?.fetchGifViewModels()
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(
                cellIdentifier: "HomeTableViewCell",
                cellType: HomeTableViewCell.self
            )) { row, viewModel, cell in
                guard let url = URL(string: viewModel.gifUrl) else {
                    return
                }
                
                cell.gifViewModel = viewModel
                cell.gifImageView.kf.setImage(with: url)
                cell.gitTitleLabel.text = viewModel.displayText
        }.disposed(by: disposeBag)
        
//        giphyDataViewModel?.fetchGifViewModels()
//            .observeOn(MainScheduler.instance)
//            .bind(
//            to: tableView.rx.items(cellIdentifier: "HomeTableViewCell")
//        ) { index, viewModel, cell in
//
//            cell.textLabel?.text = viewModel.displayText
//        }.disposed(by: disposeBag)
        
//        let service = GiphyService()
//        service.fetchGiphyData().subscribe(onNext: { (giphyResponse) in
//            print(giphyResponse)
//            }).disposed(by: disposeBag)
    }

    func searchGifs() {

        let results = searchBar.rx.text.orEmpty
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { (query) -> Observable<[GifViewModel]> in
                if query.isEmpty {
                    return self.giphyDataViewModel?.fetchGifViewModels().catchErrorJustReturn([]) ?? .just([])
                }
                
                return self.giphyDataViewModel?.searchGifViewModels(keyword: query).catchErrorJustReturn([]) ?? .just([])
        }.observeOn(MainScheduler.instance)
        
        results.bind(to: tableView.rx.items(
            cellIdentifier: "HomeTableViewCell",
            cellType: HomeTableViewCell.self
        )) { row, viewModel, cell in
            
            guard let url = URL(string: viewModel.gifUrl) else {
                return
            }
            
            cell.gifViewModel = viewModel
            cell.gifImageView.kf.setImage(with: url)
            cell.gitTitleLabel.text = viewModel.displayText
            cell.addToFavoritesButton.setTitle(viewModel.addToFavoritesButtonTitle, for: .normal)
            
        }.disposed(by: disposeBag)
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}

