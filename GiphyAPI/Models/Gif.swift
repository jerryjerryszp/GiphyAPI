//
//  Gif.swift
//  GiphyAPI
//
//  Created by Jerry Shi on 2020-09-13.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import Foundation

struct GiphyResponse: Decodable {
    let data: [Gif]
    let pagination: Pagination
    let meta: GiphyMeta
    
    
}

struct Gif: Decodable {
    let id: String
    let url: String?
    let bitly_url: String
    let embed_url: String
    let username: String
    let rating: String
    let source_post_url: String
    let trending_datetime: String
    let images: ImageDetail
    let title: String
}

struct ImageDetail: Decodable {
    let fixed_height: FixedHeight
//    let downsized: Downsized
//    let preview_gif: PreviewGif
}

struct FixedHeight: Decodable {
    let url: String
    let width: String
    let height: String
}

//struct Downsized: Decodable {
//    let url: String
//    let width: String
//    let height: String
//    let size: String
//}
//
//struct PreviewGif: Decodable {
////    let url: String
//    let width: String
//    let height: String
//}

struct Pagination: Decodable {
    let count: Int
    let offset: Int
    let total_count: Int
}

struct GiphyMeta: Decodable {
    let msg: String
    let response_id: String
    let status: Int
}
