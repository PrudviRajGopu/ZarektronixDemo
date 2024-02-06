//
//  ProductCell.swift
//  ZerktronixDemoApp
//
//  Created by Gopu on 03/02/24.
//

import UIKit
import CoreData
class ProductCell: UICollectionViewCell {

    
    @IBOutlet weak var Item_ImgView: UIImageView!
    
    @IBOutlet weak var heartBtn: UIButton!
    
    @IBOutlet weak var titleLbl: UILabel!
    private var quantity : Int = 0
    private var itemPrice = ""
    private var productId = ""
    var model = ProductStore()
    var isWishLited:Bool = false
  
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func updateWishlist() {
        if wishListItems.isEmpty {
            isWishLited = false
            heartBtn.setImage(UIImage(named: "unwish"), for: .normal)

        } else {
            for obj in wishListItems {
                if obj.productId == model.id {
                    isWishLited = true
                    heartBtn.setImage(UIImage(named: "wish"), for: .normal)
                    break
                    
                } else {
                    heartBtn.setImage(UIImage(named: "unwish"), for: .normal)

                }
            }
        }
    }

    
    @IBAction func heartBtn_Axn(_ sender: UIButton) {
        if isWishLited == false {
            addWishListItem()
        } else {
            deleteWishlistItem()
        }
        
    }
    
    
    
   
    
    func addWishListItem() {

        DataManager.shared.addWishItem(pName: model.title, itemImage: model.image, pDescrpt: model.itemDescription, productId: model.id, category: model.category, itemPrice: model.price)
        wishListItems = DataManager.shared.wishListItems()
        heartBtn.setImage(UIImage(named: "wish"), for: .normal)
        print("addWishListItem=\(wishListItems))")

        self.parentViewController?.view.makeToast("added")
//        if let VC = self.parentViewController as? HomeVC {
//            VC.trendyCV.reloadData()
//
//        }
    }
    
    func deleteWishlistItem() {
        DataManager.shared.deleteIteminWishList(productID: model.id)
        
        wishListItems = DataManager.shared.wishListItems()
        print("deleteWishlistItem=\(wishListItems))")
        heartBtn.setImage(UIImage(named: "unwish"), for: .normal)

        self.parentViewController?.view.makeToast("removed")
//        if let VC = self.parentViewController as? HomeVC {
//            VC.trendyCV.reloadData()
//
//        }
        
        
    }
    
}
