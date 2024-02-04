//
//  ProductStore+CoreDataProperties.swift
//  BagzzDemoApp
//
//  Created by Gopu on 05/02/24.
//
//

import Foundation
import CoreData


extension ProductStore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductStore> {
        return NSFetchRequest<ProductStore>(entityName: "ProductStore")
    }

    @NSManaged public var id: String
    @NSManaged public var title: String
    @NSManaged public var price: String
    @NSManaged public var itemDescription: String
    @NSManaged public var category: String
    @NSManaged public var image: String
//    @NSManaged public var rating: NSObject?

}

extension ProductStore : Identifiable {

}
