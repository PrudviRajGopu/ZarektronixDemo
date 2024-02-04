//
//  WishListVC.swift
//  ZerktronixDemoApp
//
//  Created by Gopu on 03/02/24.
//

import UIKit

class WishListVC: UIViewController {

  
    
    @IBOutlet weak var wishListTV: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        updateView()

    }
    
    func updateView() {
        wishListTV.register(UINib(nibName: "FavouritiesTVCell", bundle: nil), forCellReuseIdentifier: "FavouritiesTVCell")

        wishListTV.delegate = self
        wishListTV.dataSource = self
        wishListTV.rowHeight = 160
        wishListItems = DataManager.shared.wishListItems()
        if wishListItems.isEmpty {
        self.view.makeToast("No Favourites")
        wishListTV.isHidden = true
        wishListTV.reloadWithAnimation()

        } else {
            wishListTV.reloadWithAnimation()

        }
        print("wishListItems = \(wishListItems.count)")

    }

}
extension WishListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return wishListItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouritiesTVCell", for: indexPath) as! FavouritiesTVCell
        let cellPath = wishListItems[indexPath.row]
        cell.model = cellPath
        cell.configureCartCell()
        
        return cell
        
        }
    
   
    
   
    

}

