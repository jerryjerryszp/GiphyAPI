//
//  GifViewModel.swift
//  GiphyAPI
//
//  Created by Jerry Shi on 2020-09-13.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import Foundation
import CoreData

struct GifViewModel {
    private let gif: Gif
    
    var displayText: String {
        return gif.title
    }
    var gifUrl: String {
        return gif.images.fixed_height.url
    }
    var addToFavoritesButtonTitle: String {
        return gifExists(id: gif.id) ? "Remove" : "Save"
    }
    var gifId: String {
        return gif.id
    }
    var gifTitle: String {
        return gif.title
    }
    
    init(gif: Gif) {
        self.gif = gif
    }
    
    /**
     Check if the gif exists in coredata
    
     - Parameters:
         -  id: The id to be used for predicate
     */
    func gifExists(id: String) -> Bool {
        let fetchRequest: NSFetchRequest<FavoriteGif> = FavoriteGif.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id CONTAINS[cd] %@", id)
        
        var results: [FavoriteGif] = []
        do  {
            results = try CoreDataManager.context.fetch(fetchRequest)
        } catch {
            print("gif exists error")
        }
        
        return results.count > 0
    }
    
    /**
     Add the gif to favorites
     */
    func addToFavorites() {
        if gifExists(id: gif.id) {
            return
        }
        
        guard let url = URL(string: gif.images.fixed_height.url) else {
            return
        }
        
        let favoriteGif = FavoriteGif(context: CoreDataManager.context)
        favoriteGif.id = gif.id
        favoriteGif.title = gif.title
        
        do {
            let gifData = try Data(contentsOf: url)
            favoriteGif.gif = gifData
            CoreDataManager.saveContext()
        } catch {
            print("error")
        }
    }
    
    /**
     Remove the gif from favorites
     */
    func removeFromFavorite() {
        let fetchRequest: NSFetchRequest<FavoriteGif> = FavoriteGif.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id CONTAINS[cd] %@", gif.id)
        
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
