//
//  CartVC.swift
//  ZerktronixDemoApp
//
//  Created by Gopu on 03/02/24.
//

import UIKit
import CoreData

class CartVC: UIViewController {

 
    @IBOutlet weak var cartTV: UITableView!
        
    
    @IBOutlet weak var emptyCartImgView: UIImageView!
    
    @IBOutlet weak var totalItemsLbl: UILabel!
    
    @IBOutlet weak var totalpriceLbl: UILabel!
    
    
    
    var totalPrice : Float = 0.00
    private var totalAmt : Float = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        updateTotalPrice()
    }
    
    
    func updateUI() {
        cartTV.register(UINib(nibName: "CartTVCell", bundle: nil), forCellReuseIdentifier: "CartTVCell")

        cartTV.delegate = self
        cartTV.dataSource = self
        cartTV.rowHeight = 150
        cartList = DataManager.shared.cartItems()
        print("cartList_VC = \(cartList)")
        updateTotalPrice()
        cartTV.reloadWithAnimation()

    }
    

    func updateTotalPrice() {
        cartList = DataManager.shared.cartItems()
        totalPrice = 0.0
        if cartList.isEmpty == false {
            for obj in cartList {
            totalPrice = totalPrice + (Float(obj.price)! * Float(obj.quantity)!)
            }
            self.totalAmt = totalPrice

            emptyCartImgView.isHidden = true
            cartTV.isHidden = false
            cartTV.reloadData()
        } else {
            self.totalAmt = 0.0

            emptyCartImgView.isHidden = false
            cartTV.isHidden = true
        }
      
        

       
        self.totalpriceLbl.text = "\(self.totalAmt.rounded()) "
        self.totalItemsLbl.text = "\(cartList.count)"
    }
   

}


// MARK: UITableView delegates and data source
extension CartVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return cartList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTVCell", for: indexPath) as! CartTVCell
       
        cell.configureCartCell(model: cartList[indexPath.row])
        
        
        return cell
        
        }
    
   
    
   
    

}
