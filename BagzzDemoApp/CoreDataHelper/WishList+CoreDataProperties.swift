//
//  WishList+CoreDataProperties.swift
//  BagzzDemoApp
//
//  Created by Gopu on 05/02/24.
//
//

import Foundation
import CoreData


extension WishList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WishList> {
        return NSFetchRequest<WishList>(entityName: "WishList")
    }

    @NSManaged public var price: String?
    @NSManaged public var prodcutName: String?
    @NSManaged public var productDescription: String?
    @NSManaged public var productId: String?
    @NSManaged public var productImage: String?
    @NSManaged public var category: String?
    @NSManaged public var userId: String?

}

extension WishList : Identifiable {

}
