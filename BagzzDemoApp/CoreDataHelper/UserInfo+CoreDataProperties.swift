//
//  UserInfo+CoreDataProperties.swift
//  BagzzDemoApp
//
//  Created by Gopu on 04/02/24.
//
//

import Foundation
import CoreData


extension UserInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserInfo> {
        return NSFetchRequest<UserInfo>(entityName: "UserInfo")
    }

    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var password: String?
    @NSManaged public var userId: String?



}

extension UserInfo {

    @objc(addSongsObject:)
    @NSManaged public func addToCart(_ value: CartItems)

    @objc(removeSongsObject:)
    @NSManaged public func removeFromCart(_ value: CartItems)
    @objc(addwishListsObject:)
    @NSManaged public func addToWishList(_ value: CartItems)

    @objc(removeWishListObject:)
    @NSManaged public func removeFromWishList(_ value: CartItems)

    @objc(addSongs:)
    @NSManaged public func addToCart(_ values: NSSet)

    @objc(removeSongs:)
    @NSManaged public func removeFromCart(_ values: NSSet)
    
    @objc(addWishList:)
    @NSManaged public func addToWishList(_ values: NSSet)

    @objc(removeWishList:)
    @NSManaged public func removeFromWishList(_ values: NSSet)

}

extension UserInfo : Identifiable {

}
