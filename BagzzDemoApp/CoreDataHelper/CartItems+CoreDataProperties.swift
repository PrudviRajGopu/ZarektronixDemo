//
//  CartItems+CoreDataProperties.swift
//  BagzzDemoApp
//
//  Created by Gopu on 04/02/24.
//
//

import Foundation
import CoreData


extension CartItems {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CartItems> {
        return NSFetchRequest<CartItems>(entityName: "CartItems")
    }

    @NSManaged public var price: String
    @NSManaged public var prodcutName: String
    @NSManaged public var productDescription: String
    @NSManaged public var productId: String
    @NSManaged public var productImage: String
    @NSManaged public var quantity: String
    @NSManaged public var userId: String
//    @NSManaged public var user: UserInfo?


}

extension CartItems : Identifiable {

}
