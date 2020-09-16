//
//  GiphyDataViewModel.swift
//  GiphyAPI
//
//  Created by Jerry Shi on 2020-09-13.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import Foundation
import RxSwift

final class GiphyDataViewModel {
    let title = Constants.GifsViewModel.title
    let favoritesTitle = Constants.GifsViewModel.favoritesTitle
    
    private let giphyService: GiphyServiceProtocol
    
    init(giphyService: GiphyServiceProtocol = GiphyService()) {
        self.giphyService = giphyService
    }
    
    func fetchGifViewModels() -> Observable<[GifViewModel]> {
        giphyService.fetchGiphyData().map {
            $0.map { GifViewModel(gif: $0) }
        }
    }
    
    func searchGifViewModels(keyword: String) -> Observable<[GifViewModel]> {
        giphyService.searchGiphyData(keyword: keyword).map {
            $0.map { GifViewModel(gif: $0) }
        }
    }
}
