//
//  FavouritiesTVCell.swift
//  ZerktronixDemoApp
//
//  Created by Gopu on 03/02/24.
//

import UIKit
import CoreData
class FavouritiesTVCell: UITableViewCell {

    
    @IBOutlet weak var descrptLbl: UILabel!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    
    @IBOutlet weak var priceLbl: UILabel!
    
    @IBOutlet weak var productImgView: UIImageView!
    var model = WishList()
    private var quantity : Int = 0
    private var productId = ""
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
    
    @IBAction func removeBtn_Axn(_ sender: UIButton) {
        
        deleteWishlistItem()
    }
    
    func configureCartCell() {
        print("model = \(model)")
        productId = model.productId!
        
        self.titleLbl.text = model.prodcutName
        self.descrptLbl.text = model.productDescription
        self.priceLbl.text = "₹: \(model.price ?? "")"
        
        
        if model.productImage!.isEmpty == false {
            productImgView.setImage(urlStr: model.productImage!)
            
        } else {
            self.productImgView.image = UIImage(named: "bagzzblack")
            
        }
        
    }
    
    func deleteWishlistItem() {
        DataManager.shared.deleteIteminWishList(productID: model.productId!)
        
        wishListItems = DataManager.shared.wishListItems()
        print("deleteWishlistItem=\(wishListItems))")
        self.parentViewController?.view.makeToast("removed")

        if let VC = self.parentViewController as? WishListVC {
            VC.wishListTV.reloadData()

        }
        
    }
    
    
}
