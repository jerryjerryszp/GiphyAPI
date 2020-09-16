//
//  Constants.swift
//  GiphyAPI
//
//  Created by Jerry Shi on 2020-09-13.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import Foundation

struct Constants {
    struct API {
        static let api_keyKey = "api_key"
        static let qKey = "q"
        static let limitKey = "limit"
        static let offsetKey = "offset"
        static let ratingKey = "rating"
        static let langKey = "lang"
        static let random_idKey = "random_id"
        
        static let trendingAPI = "https://api.giphy.com/v1/gifs/trending"
        static let randomAPI = "https://api.giphy.com/v1/gifs/random"
        static let searchAPI = "https://api.giphy.com/v1/gifs/search"
        
        static let api_key = "e7OfoUnnKGUOF1YExEYRzEoh8fghL9oz"
        static let limit = 20
        static let offset = 5
        static let rating = "g"
        static let lang = "en"
        static let random_id = "e826c9fc5c929e0d6c6d423841a282aa"
    }
    
    struct Storyboard {
        static let mainStoryboardName = "Main"
        static let storyboardPrefixSegueIdentifier = "Show"

        static func createStoryboardSegueIdentifier(forClassName className: String) -> String {
            return storyboardPrefixSegueIdentifier + className
        }
    }
    
    struct GifsViewModel {
        static let title = "Giphy"
    }
}
