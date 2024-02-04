//
//  ProdcutDetailsVC.swift
//  BagzzDemoApp
//
//  Created by Gopu on 05/02/24.
//

import UIKit
import CoreData


class ProdcutDetailsVC: UIViewController {
    @IBOutlet weak var qtyLbl: UILabel!
    
    @IBOutlet weak var qtySV: UIStackView!
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var productTitleLbl: UILabel!
    
    @IBOutlet weak var priceLbl: UILabel!
    
    @IBOutlet weak var wishListBtn: UIButton!
   
    
    @IBOutlet weak var prodcutImgView: UIImageView!
    
    
    @IBOutlet weak var optionsCV: UICollectionView!
    
    
    
    @IBOutlet weak var dataTV: UITableView!
    
    
    private var productId : String = ""
    private var itemPrice : String = "0"
    private var quantity : Int = 0
    var optionsArr:[String] = ["Description","Shipping info","Payment options"]
    var isWishLited:Bool = false

    var selectedInd = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        updateView()
    }
    func updateView() {
        wishListItems = DataManager.shared.wishListItems()
        productTitleLbl.text = SelectedItem.itemSelected.title
        prodcutImgView.setImage(urlStr: SelectedItem.itemSelected.image)
        priceLbl.text = "₹ \(SelectedItem.itemSelected.price)"
        optionsCV.delegate = self
        optionsCV.dataSource = self
        dataTV.delegate = self
        dataTV.dataSource = self
        
        optionsCV.reloadData()
        self.optionsCV.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
        updateCartIt()
        updateWishlist()

    }
    func updateCartIt() {
        cartList = DataManager.shared.cartItems()
        if cartList.isEmpty == false {
            for inde in cartList {
                if inde.productId == SelectedItem.itemSelected.id {
                    qtySV.isHidden = false
                    addBtn.isHidden = true
                    qtyLbl.text = inde.quantity
                    quantity = Int(inde.quantity) ?? 0
                    break
                } else {
                    addBtn.isHidden = false
                    qtySV.isHidden = true
                }
            }
        } else {
            addBtn.isHidden = false
            qtySV.isHidden = true
        }
    }
    
   

    @IBAction func backBtnAxn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func plusBtn(_ sender: UIButton) {
           
       
        if quantity >= 0 {
            quantity = quantity + 1
            self.qtyLbl.text = "\(quantity)"
           
           updateCartItem()

        } 
    }
    
    @IBAction func minusBTnAxn(_ sender: UIButton) {
        if quantity > 1 {
            
        quantity = quantity - 1
        self.qtyLbl.text = "\(quantity)"
           updateCartItem()
          
                
        } else {
        quantity = 0
        self.qtyLbl.text = "0"
            deleteCartItem()
        self.qtySV.isHidden = true
        self.addBtn.isHidden = false
            
        
        }
    }
    
    func updateWishlist() {
        if wishListItems.isEmpty {
            isWishLited = false
            wishListBtn.setImage(UIImage(named: "unwish"), for: .normal)

        } else {
            for obj in wishListItems {
                if obj.productId == SelectedItem.itemSelected.id {
                    isWishLited = true
                    wishListBtn.setImage(UIImage(named: "wish"), for: .normal)
                    break
                    
                } else {
                    wishListBtn.setImage(UIImage(named: "unwish"), for: .normal)

                }
            }
        }
    }
    
    func updateCartItem() {
        print("cartupdaTeBeforer = \(cartList)")

       DataManager.shared.updateCartItem(productId: SelectedItem.itemSelected.id, qty: "\(quantity)")
        DataManager.shared.save()

        cartList = DataManager.shared.cartItems()
         print("cartListAfter = \(cartList)")
        self.view.makeToast("cart updated ")

    }
    
    func addCartItem() {
        print("cartAddeBeforer=\(cartList)")

        DataManager.shared.addCartItem(pName: SelectedItem.itemSelected.title, itemImage: SelectedItem.itemSelected.image, pDescrpt: SelectedItem.itemSelected.itemDescription, productId: SelectedItem.itemSelected.id, qty: "1", itemPrice: SelectedItem.itemSelected.price)
        DataManager.shared.save()
        
        cartList = DataManager.shared.cartItems()
        print("CartafterAdded=\(cartList))")

        self.view.makeToast("added to cart")
        qtySV.isHidden = false
        addBtn.isHidden = true
    }
    
    func deleteCartItem() {
        print("Cart_Now=\(cartList)")
        DataManager.shared.deleteIteminCart(productId: SelectedItem.itemSelected.id)
        DataManager.shared.save()

        cartList = DataManager.shared.cartItems()
        print("CartDeleted=\(cartList))")

        self.view.makeToast("deleted from cart")
      
       
        qtySV.isHidden = true
        addBtn.isHidden = false
    }
    
    
    
    @IBAction func add_Item_Btn_axn(_ sender: UIButton) {
        if quantity == 0 {
            print("Adding quantity")

            quantity = 1
            addCartItem()
            
        }
        print("Adding CartItem")

    }
    
    
    
    @IBAction func wishListBtn_Axn(_ sender: UIButton) {
        if isWishLited == false {
            addWishListItem()
        } else {
            deleteWishlistItem()
        }
    }
    
    
    func addWishListItem() {

        DataManager.shared.addWishItem(pName: SelectedItem.itemSelected.title, itemImage: SelectedItem.itemSelected.image, pDescrpt: SelectedItem.itemSelected.itemDescription, productId: SelectedItem.itemSelected.id, category: SelectedItem.itemSelected.category, itemPrice: SelectedItem.itemSelected.price)
        wishListItems = DataManager.shared.wishListItems()
        wishListBtn.setImage(UIImage(named: "wish"), for: .normal)
        print("addWishListItem=\(wishListItems))")

        self.view.makeToast("added")
        
    }
    
    func deleteWishlistItem() {
        DataManager.shared.deleteIteminWishList(productID: SelectedItem.itemSelected.id)
        
        wishListItems = DataManager.shared.wishListItems()
        print("deleteWishlistItem=\(wishListItems))")
        wishListBtn.setImage(UIImage(named: "unwish"), for: .normal)
        self.view.makeToast("removed")
        
        
    }
    

}


extension ProdcutDetailsVC : UICollectionViewDelegate,UICollectionViewDataSource , UITableViewDataSource , UITableViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return optionsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCVCell", for: indexPath) as! DetailsCVCell
        cell.titleLbl.text = optionsArr[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            
        } else if indexPath.item == 1 {
            
        } else {
            
        }
        selectedInd = indexPath.item
        dataTV.reloadWithAnimation()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedInd == 0 {
           return ItemDetails.itemDesrciptArr.count
        } else if selectedInd == 1 {
            return ItemDetails.shippingInfoArr.count

        } else {
            return ItemDetails.paymentInfoArr.count

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath)
        if selectedInd == 0 {
            cell.textLabel?.text = ItemDetails.itemDesrciptArr[indexPath.row]

        } else if selectedInd == 1 {
            cell.textLabel?.text = ItemDetails.shippingInfoArr[indexPath.row]

        } else {
            cell.textLabel?.text = ItemDetails.paymentInfoArr[indexPath.row]

        }
        
        
        return cell
    }
    
    
    
    
    
}


          
                                                      
                                                      
                                                      
                                                      

 
