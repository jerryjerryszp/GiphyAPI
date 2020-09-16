//
//  FavoriteGifsViewModel.swift
//  GiphyAPI
//
//  Created by Jerry Shi on 2020-09-16.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import Foundation
import RxSwift
import CoreData

final class FavoriteGifsViewModel {
    let favoritesTitle = Constants.GifsViewModel.favoritesTitle
    private let favoriteGifsServiceProtocol: FavoriteGifsServiceProtocol
    
    init(favoriteGifsServiceProtocol: FavoriteGifsServiceProtocol = FavoriteGifsService()) {
        self.favoriteGifsServiceProtocol = favoriteGifsServiceProtocol
    }
    
    func fetchFavoriteGifViewModels() -> Observable<[FavoriteGifViewModel]> {
        favoriteGifsServiceProtocol.fetchFavoriteGifs().map {
            $0.map { FavoriteGifViewModel(favoriteGif: $0) }
        }
    }
}
