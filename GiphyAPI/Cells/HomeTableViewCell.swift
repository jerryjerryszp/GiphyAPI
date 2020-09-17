//
//  HomeTableViewCell.swift
//  GiphyAPI
//
//  Created by Jerry Shi on 2020-09-15.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class HomeTableViewCell: UITableViewCell {
    // MARK: IBOutlets
    @IBOutlet weak var gifImageViewContainer: UIView!
    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var gitTitleLabel: UILabel!
    @IBOutlet weak var addToFavoritesButton: UIButton!
    
    // MARK: Properties
    var gifViewModel: GifViewModel?
    var disposeBag = DisposeBag()
    var addToFavoritesButtonTap: Observable<Void> {
        return self.addToFavoritesButton.rx.tap.asObservable()
    }
    
    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
