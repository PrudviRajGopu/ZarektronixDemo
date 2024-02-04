//
//  CoreDataM.swift
//  BagzzDemoApp
//
//  Created by Gopu on 04/02/24.
//

import Foundation
import CoreData

class DataManager {
    
    static let shared = DataManager()
//    let cdm = CoreDataManager.sharedInstance

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BagzzDemoApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func user(email: String,fName:String,lName:String,pass:String,userId:String) -> UserInfo {
        let user = UserInfo(context: persistentContainer.viewContext)
        user.email = email
        user.firstName = fName
        user.lastName = lName
        user.userId = userId
        user.password = pass
        return user
    }
    
    func checkUser(email:String,passWord:String)->UserInfo? {
        
        let request: NSFetchRequest<UserInfo> = UserInfo.fetchRequest()
        var fetchedUsers: [UserInfo] = []
        
        do {
            fetchedUsers = try persistentContainer.viewContext.fetch(request)
            for result in fetchedUsers {
                if  email == result.email && passWord == result.password{
                    print("fetchCurrentUser = \(result)")
                    
                    return result
                    
                }
               
            }
        } catch let error {
            print("Error fetching singers \(error)")
        }
        return nil
        
    }
    
    
    func addWishItem(pName: String,itemImage:String, pDescrpt: String, productId:String,category:String,itemPrice:String)  {
        let wishItem = WishList(context: persistentContainer.viewContext)
        wishItem.productId = productId
        wishItem.prodcutName = pName
        wishItem.productImage = itemImage
        wishItem.productDescription = pDescrpt
        wishItem.category = category
        wishItem.price = itemPrice
        wishItem.userId = Preferrences.getUserID()
    }
    
    func wishListItems() -> [WishList] {
        let request: NSFetchRequest<WishList> = WishList.fetchRequest()
        request.predicate = NSPredicate(format: "userId = %@", Preferrences.getUserID())
//        request.sortDescriptors = [NSSortDescriptor(key: "releaseDate", ascending: false)]
        var fetchedItems: [WishList] = []
        
        do {
            fetchedItems = try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print("Error fetching songs \(error)")
        }
        return fetchedItems
    }
    func addStoreItem(pName: String,itemImage:String, pDescrpt: String, productId:String,category:String,itemPrice:String) -> ProductStore {
        let storeItem = ProductStore(context: persistentContainer.viewContext)
        storeItem.id = productId
        storeItem.title = pName
        storeItem.image = itemImage
        storeItem.itemDescription = pDescrpt
        storeItem.category = category
        storeItem.price = itemPrice

        return storeItem
    }
    
    func storeItems() -> [ProductStore] {
        let request: NSFetchRequest<ProductStore> = ProductStore.fetchRequest()
//        request.predicate = NSPredicate(format: "userId = %@", Preferrences.getUserID())
//        request.sortDescriptors = [NSSortDescriptor(key: "releaseDate", ascending: false)]
        var fetchedItems: [ProductStore] = []
        
        do {
            fetchedItems = try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print("Error fetching songs \(error)")
        }
        return fetchedItems
    }
    

//    func addCartItem(pName: String,itemImage:String, pDescrpt: String,productId:String,qty:String) -> CartItems {
//        let cartItem = CartItems(context: persistentContainer.viewContext)
//        cartItem.prodcutName = pName
//        cartItem.productDescription = pDescrpt
//        cartItem.productId = productId
//        cartItem.userId = Preferrences.getUserID()
//        cartItem.quantity = qty
//        cartItem.productDescription = pDescrpt
//        cartItem.productImage = itemImage
//
//
////        user.addToCart(cartItem)
//        return cartItem
//    }
    
    func addCartItem(pName: String,itemImage:String, pDescrpt: String,productId:String,qty:String,itemPrice:String)  {
        let cartItem = CartItems(context: persistentContainer.viewContext)
        cartItem.prodcutName = pName
        cartItem.productDescription = pDescrpt
        cartItem.productId = productId
        cartItem.userId = Preferrences.getUserID()
        cartItem.quantity = qty
        cartItem.productDescription = pDescrpt
        cartItem.productImage = itemImage
        cartItem.price = itemPrice
        save()

    }
    

    
    func users() -> [UserInfo] {
        let request: NSFetchRequest<UserInfo> = UserInfo.fetchRequest()
        var fetchedUsers: [UserInfo] = []
        
        do {
            fetchedUsers = try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print("Error fetching singers \(error)")
        }
        return fetchedUsers
    }
    
    func updateCartItem(productId:String,qty:String) {
        let request: NSFetchRequest<CartItems> = CartItems.fetchRequest()
        request.predicate = NSPredicate(format: "productId = %@", productId)
//        request.sortDescriptors = [NSSortDescriptor(key: "releaseDate", ascending: false)]
        var fetchedItems: [CartItems] = []
        
        
        do {
            fetchedItems = try persistentContainer.viewContext.fetch(request)
            if fetchedItems.isEmpty == false {
                var managedObject = fetchedItems[0]
                managedObject.quantity = qty
                save()
            }
        } catch let error {
            print("Error fetching songs \(error)")
        }
    }

//    func updateCartItem(productId:String,qty:String)->[CartItems] {
//        let request: NSFetchRequest<CartItems> = CartItems.fetchRequest()
//        request.predicate = NSPredicate(format: "productId = %@", productId)
////        request.sortDescriptors = [NSSortDescriptor(key: "releaseDate", ascending: false)]
//        var fetchedItems: [CartItems] = []
//
//
//        do {
//            fetchedItems = try persistentContainer.viewContext.fetch(request)
//            if fetchedItems.isEmpty == false {
//                var managedObject = fetchedItems[0]
//                managedObject.quantity = qty
//                save()
//            }
//        } catch let error {
//            print("Error fetching songs \(error)")
//        }
//        return fetchedItems
//    }
    
    func cartItems() -> [CartItems] {

        let request: NSFetchRequest<CartItems> = CartItems.fetchRequest()
        request.predicate = NSPredicate(format: "userId == %@", Preferrences.getUserID())
//        request.sortDescriptors = [NSSortDescriptor(key: "releaseDate", ascending: false)]
        var fetchedItems: [CartItems] = []
        print("fetchedcartItems = \(fetchedItems)")
        do {
            fetchedItems = try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print("Error fetching cartItems \(error)")
        }
        return fetchedItems
    }
    
    // MARK: - Core Data Saving support
    func save() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("❗️Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    func deleteIteminWishList(productID:String) {
        let context = persistentContainer.viewContext

        let request: NSFetchRequest<WishList> = WishList.fetchRequest()
        request.predicate = NSPredicate(format: "productId = %@", productID)
//        request.sortDescriptors = [NSSortDescriptor(key: "releaseDate", ascending: false)]
        var fetchedItems: [WishList] = []


        do {
            fetchedItems = try persistentContainer.viewContext.fetch(request)
            if fetchedItems.isEmpty == false {
                var managedObject = fetchedItems[0]
                context.delete(managedObject)
                save()
            }
        } catch let error {
            print("Error fetching songs \(error)")
        }
//        let context = persistentContainer.viewContext
//        context.delete(item)
//        save()
    }
    
    func deleteIteminCart(productId:String) {
        let context = persistentContainer.viewContext

        let request: NSFetchRequest<CartItems> = CartItems.fetchRequest()
        request.predicate = NSPredicate(format: "productId = %@", productId)
//        request.sortDescriptors = [NSSortDescriptor(key: "releaseDate", ascending: false)]
        var fetchedItems: [CartItems] = []


        do {
            fetchedItems = try persistentContainer.viewContext.fetch(request)
            if fetchedItems.isEmpty == false {
                var managedObject = fetchedItems[0]
                context.delete(managedObject)
                save()
            }
        } catch let error {
            print("Error fetching songs \(error)")
        }


    }
//    func deleteIteminCart(item: CartItems) {
//        let context = persistentContainer.viewContext
//        context.delete(item)
//        save()
//    }
    
    func deleteUser(user: UserInfo) {
        let context = persistentContainer.viewContext
        context.delete(user)
        save()
    }
    
    func deleteAllUsers() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "UserInfo")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let context = persistentContainer.viewContext

        do {
            try context.execute(deleteRequest)
            print("deleteAllUsers=\(DataManager.shared.users())")

            deleteAllCartItems()
        } catch let error as NSError {
            // TODO: handle the error
        }
    }
    
    func deleteAllCartItems() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CartItems")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let context = persistentContainer.viewContext

        do {
            try context.execute(deleteRequest)
            print("deleteAllCartItems=\(DataManager.shared.cartItems())")
        } catch let error as NSError {
            // TODO: handle the error
        }
    }
}
extension NSManagedObject {
  func toJSON() -> String? {
    let keys = Array(self.entity.attributesByName.keys)
    let dict = self.dictionaryWithValues(forKeys: keys)
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        let reqJSONStr = String(data: jsonData, encoding: .utf8)
        return reqJSONStr
    }
    catch{}
    return nil
  }
    func convertToJSON() -> [String:Any] {
            var dict: [String: Any] = [:]
            for attribute in self.entity.attributesByName {
                //check if value is present, then add key to dictionary so as to avoid the nil value crash
                if let value = self.value(forKey: attribute.key) {
                    dict[attribute.key] = value
                }
            
        }
        return dict
    }
   
}


