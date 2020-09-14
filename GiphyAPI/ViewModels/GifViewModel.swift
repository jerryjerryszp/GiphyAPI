//
//  GifViewModel.swift
//  GiphyAPI
//
//  Created by Jerry Shi on 2020-09-13.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import Foundation

struct GifViewModel {
    private let gif: Gif
    
    var displayText: String {
        return gif.title
    }
    
    init(gif: Gif) {
        self.gif = gif
    }
}
