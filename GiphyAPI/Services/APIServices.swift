//
//  APIServices.swift
//  GiphyAPI
//
//  Created by Jerry Shi on 2020-09-13.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import Foundation
import RxSwift
import CoreData

protocol GiphyServiceProtocol {
    func fetchGiphyData() -> Observable<[Gif]>
    func searchGiphyData(keyword: String) -> Observable<[Gif]>
}

protocol FavoriteGifsServiceProtocol {
    func fetchFavoriteGifs() -> Observable<[FavoriteGif]>
}

class GiphyService: GiphyServiceProtocol {
    
    func fetchGiphyData() -> Observable<[Gif]> {
        return Observable.create { observer -> Disposable in
            let parameters = [
                Constants.API.api_keyKey: Constants.API.api_key,
                Constants.API.limitKey: Constants.API.limit,
                Constants.API.offsetKey: Constants.API.offset,
                Constants.API.ratingKey: Constants.API.rating,
                Constants.API.random_idKey: Constants.API.random_id
                ] as [String : Any]
            
            let url = URL(string: Constants.API.trendingAPI)!
            
            APIManager.shared.request(url: url, parameters: parameters) { (response, error) in

                if let data = response {
                    do {
                        let result = try JSONDecoder().decode(GiphyResponse.self, from: data)
                        
                        let gifs = result.data.sorted(by: {
                            $0.trending_datetime.lowercased() > $1.trending_datetime.lowercased()
                        })
                        
                        observer.onNext(gifs)
                    } catch {
                        observer.onError(error)
                    }
                }
            }
            
            return Disposables.create {}
        }
    }
    
    func searchGiphyData(keyword: String) -> Observable<[Gif]> {
        return Observable.create { observer -> Disposable in
            let parameters = [
                Constants.API.qKey: keyword,
                Constants.API.api_keyKey: Constants.API.api_key,
                Constants.API.limitKey: Constants.API.limit,
                Constants.API.offsetKey: Constants.API.offset,
                Constants.API.ratingKey: Constants.API.rating,
                Constants.API.random_idKey: Constants.API.random_id
                ] as [String : Any]
            
            let url = URL(string: Constants.API.searchAPI)!
            
            APIManager.shared.request(url: url, parameters: parameters) { (response, error) in

                if let data = response {
                    do {
                        let result = try JSONDecoder().decode(GiphyResponse.self, from: data)
                        
                        let gifs = result.data.sorted(by: {
                            $0.trending_datetime.lowercased() > $1.trending_datetime.lowercased()
                        })
                        
                        observer.onNext(gifs)
                    } catch {
                        observer.onError(error)
                    }
                }
            }
            
            return Disposables.create {}
        }
    }
}

class FavoriteGifsService: FavoriteGifsServiceProtocol {
    func fetchFavoriteGifs() -> Observable<[FavoriteGif]> {
        return Observable.create { observer -> Disposable in
            
            let fetchRequest: NSFetchRequest<FavoriteGif> = FavoriteGif.fetchRequest()
                    
            do {
                let savedGifs = try CoreDataManager.context.fetch(fetchRequest)
                observer.onNext(savedGifs)
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create {}
        }
    }
}
