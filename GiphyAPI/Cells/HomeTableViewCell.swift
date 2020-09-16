//
//  HomeTableViewCell.swift
//  GiphyAPI
//
//  Created by Jerry Shi on 2020-09-15.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import Foundation
import UIKit

class HomeTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var gifImageViewContainer: UIView!
    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var gitTitleLabel: UILabel!
    @IBOutlet weak var addToFavoritesButton: UIButton!
    
    // MARK: Properties
    var gifViewModel: GifViewModel?
    
    // MARK: IBActions
    @IBAction func addToFavorites(_ sender: Any) {
        if addToFavoritesButton.currentTitle == "Save" {
            gifViewModel?.addToFavorites()
        } else {
            gifViewModel?.removeFromFavorite()
        }
    }
    
    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
