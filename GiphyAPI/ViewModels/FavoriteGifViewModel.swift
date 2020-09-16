//
//  FavoriteGifViewModel.swift
//  GiphyAPI
//
//  Created by Jerry Shi on 2020-09-16.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import Foundation
import CoreData

struct FavoriteGifViewModel {
    private let favoriteGif: FavoriteGif
    
    var gifData: Data? {
        return favoriteGif.gif ?? nil
    }
    
    var buttonTitle: String {
        return "Remove"
    }
    
    init(favoriteGif: FavoriteGif) {
        self.favoriteGif = favoriteGif
    }
    
    /**
     Remove the gif from favorites
     */
    func removeFromFavorite() {
        guard let gifId = favoriteGif.id else {
            return
        }
        
        let fetchRequest: NSFetchRequest<FavoriteGif> = FavoriteGif.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id CONTAINS[cd] %@", gifId)
        
        var results: [FavoriteGif] = []
        do  {
            results = try CoreDataManager.context.fetch(fetchRequest)
            
            if let gifToBeRemoved = results.first {
                CoreDataManager.context.delete(gifToBeRemoved)
                CoreDataManager.saveContext()
            }
        } catch {
            print("gif removal error")
        }
    }
}
