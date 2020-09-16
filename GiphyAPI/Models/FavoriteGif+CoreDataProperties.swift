//
//  FavoriteGif+CoreDataProperties.swift
//  
//
//  Created by Jerry Shi on 2020-09-16.
//
//

import Foundation
import CoreData


extension FavoriteGif {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteGif> {
        return NSFetchRequest<FavoriteGif>(entityName: "FavoriteGif")
    }

    @NSManaged public var gif: Data?
    @NSManaged public var title: String?
    @NSManaged public var id: String?

}
