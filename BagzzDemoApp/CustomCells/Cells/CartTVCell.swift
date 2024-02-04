//
//  CartTVCell.swift
//  BagzzDemoApp
//
//  Created by Gopu on 05/02/24.
//

import UIKit
import CoreData

class CartTVCell: UITableViewCell {
    
    @IBOutlet weak var productImgView: UIImageView!
    
    @IBOutlet weak var qtyLbl: UILabel!
    
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var productDescrptLbl: UILabel!
    
    @IBOutlet weak var productTitleLbl: UILabel!
    
    @IBOutlet weak var minusBtn: UIButton!
    
    @IBOutlet weak var plusBtn: UIButton!
    
    @IBOutlet weak var qtySV: UIStackView!
    private var quantity : Int = 0
    private var itemPrice = ""
    private var productId = ""

    var deleteItemAction: (() -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func plusBtnAxn(_ sender: UIButton) {
        if quantity >= 0 {
            quantity = quantity + 1
            self.qtyLbl.text = "\(quantity)"
           
           updateCartItem()

        } 
    }
    
    
    @IBAction func minusBtnAxn(_ sender: UIButton) {
        if quantity > 1 {
            
        quantity = quantity - 1
        self.qtyLbl.text = "\(quantity)"
           updateCartItem()
          
                
        } else {
        quantity = 0
        self.qtyLbl.text = "0"
            deleteCartItem()
           
        
        }
    }
    
    func configureCartCell(model : CartItems) {
        print("model = \(model)")
//        cartModel = model
        productId = model.productId
        itemPrice = model.price
        
        self.productTitleLbl.text = model.prodcutName
        self.quantity = Int(model.quantity ) ?? 0
        
        self.priceLbl.text = "₹: \(model.price)"
        self.qtyLbl.text = "\(quantity)"
        
        
        if model.productImage.isEmpty == false {
            productImgView.setImage(urlStr: model.productImage)
            
        } else {
            self.productImgView.image = UIImage(named: "bagzzblack")
            
        }
        
        
        
    }
    func updateCartItem() {
        print("cartupdaTeBeforer = \(cartList)")

       DataManager.shared.updateCartItem(productId: productId, qty: "\(quantity)")
        cartList = DataManager.shared.cartItems()
         print("cartListAfter = \(cartList)")
        self.parentContainerViewController()?.view.makeToast("cart updated ")
        if let VC = self.parentViewController as? CartVC {
            VC.cartTV.reloadData()
            VC.updateTotalPrice()
        }
    }
    
    func addCartItem() {
        print("cartAddeBeforer=\(cartList)")

        DataManager.shared.addCartItem(pName: SelectedItem.itemSelected.title, itemImage: SelectedItem.itemSelected.image, pDescrpt: SelectedItem.itemSelected.itemDescription, productId: SelectedItem.itemSelected.id, qty: "1", itemPrice: SelectedItem.itemSelected.price)
        cartList = DataManager.shared.cartItems()
        print("CartafterAdded=\(cartList))")

        self.parentContainerViewController()?.view.makeToast("added to cart")
        if let VC = self.parentViewController as? CartVC {
            VC.cartTV.reloadData()
            VC.updateTotalPrice()

        }
    }
    
    func deleteCartItem() {
        print("Cart_Now=\(cartList)")
        DataManager.shared.deleteIteminCart(productId:productId )
        
        cartList = DataManager.shared.cartItems()
        print("CartDeleted=\(cartList))")

        self.parentViewController?.view.makeToast("deleted from cart")
      
        if let VC = self.parentViewController as? CartVC {
            VC.cartTV.reloadData()
            VC.updateTotalPrice()

        }
        
    }


}

