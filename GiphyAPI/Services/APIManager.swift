//
//  APIManager.swift
//  GiphyAPI
//
//  Created by Jerry Shi on 2020-09-13.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    // MARK: Properties
    static let shared = APIManager()
    
    // MARK: Public
    /**
     Network request - GET
    
     - Parameters:
         -  url: The endpoint url
         - parameters: The endpoint parameters
         - completion: The completion handler
     */
    func request(url: URL, parameters: [String: Any], completion: @escaping (Data?, Error?) -> Void) {
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (response) in
            completion(response.data, response.error)
        }
    }
}
