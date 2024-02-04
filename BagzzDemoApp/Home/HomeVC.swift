//
//  HomeVC.swift
//  ZerktronixDemoApp
//
//  Created by Gopu on 03/02/24.
//

import UIKit
import SideMenuSwift

class HomeVC: UIViewController {

    
    @IBOutlet weak var sliderCV: UICollectionView!
    
    @IBOutlet weak var offersCV: UICollectionView!
    
    @IBOutlet weak var categoryCV: UICollectionView!
    
    @IBOutlet weak var trendyCV: UICollectionView!
    
    var bagImgArr:[String] = ["bag1","bag2","bag3","bag4","bag5","bag6","bag7","bag8"]
    var bagTitleArr:[String] = ["Artsy","Berkely","Capucinus","Monogram","Artsy","Berkely","Capucinus","Monogram"]

    var sliders:[String] = ["slider1","Slider2","slider3","slider4"]
    var offerSlides:[String] = ["slider5","slider6","slider7","slider3"]
    var catImgArr:[String] = ["Cat1","Cat2","Cat3","Cat4","Cat1","Cat2","Cat3","Cat4"]
    var itemDescrptStr = "As in handbags, the double ring and bar design defines the wallet shape, highlighting the front flap closure which is tucked inside the hardware. Completed with an organizational interior, the black leather wallet features a detachable chain."

    override func viewDidLoad() {
        super.viewDidLoad()

        updateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        trendyCV.reloadData()
    }
    
    func updateView() {
        self.sliderCV.dataSource = self
        self.sliderCV.delegate = self
        sliderCV.register(UINib(nibName: "SlidersCell", bundle: nil), forCellWithReuseIdentifier: "SlidersCell")

        self.offersCV.dataSource = self
        self.offersCV.delegate = self
        offersCV.register(UINib(nibName: "SlidersCell", bundle: nil), forCellWithReuseIdentifier: "SlidersCell")

        self.categoryCV.dataSource = self
        self.categoryCV.delegate = self
        categoryCV.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")

        self.trendyCV.dataSource = self
        self.trendyCV.delegate = self
        trendyCV.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")

      

    }
    
    @IBAction func menuBtn_Axn(_ sender: UIButton) {
        
        SideMenuController.preferences.basic.menuWidth = 250
        SideMenuController.preferences.basic.statusBarBehavior = .hideOnMenu
//        SideMenuController.preferences.basic.position = .below
        SideMenuController.preferences.basic.direction = .left
        SideMenuController.preferences.basic.enablePanGesture = true
        SideMenuController.preferences.basic.supportedOrientations = .portrait
        SideMenuController.preferences.basic.shouldRespectLanguageDirection = true
        sideMenuController?.revealMenu()

    }
    
 

}

extension HomeVC : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == sliderCV {
            return sliders.count

        } else if collectionView == offersCV {
            return offerSlides.count
            
        } else if collectionView == categoryCV {
            return storeItems.count
        } else {
            return storeItems.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        if collectionView == sliderCV {
            let sliderCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlidersCell", for: indexPath) as! SlidersCell
            sliderCell.slider_ImgView.image = UIImage(named: sliders[indexPath.item])
            sliderCell.layer.cornerRadius = 10
            sliderCell.layer.borderColor = UIColor.lightText.cgColor
            sliderCell.layer.borderWidth = 0.5
            return sliderCell

        } else if collectionView == offersCV {
            let offerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlidersCell", for: indexPath) as! SlidersCell
            offerCell.slider_ImgView.image = UIImage(named: offerSlides[indexPath.item])

            offerCell.layer.cornerRadius = 10
            offerCell.layer.borderColor = UIColor.lightText.cgColor
            offerCell.layer.borderWidth = 0.5
            return offerCell
            
        
            
        } else if collectionView == categoryCV{
            let catCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
            let cellPath = storeItems[indexPath.item]

            catCell.imgView.setImage(urlStr: cellPath.image)

            catCell.layer.cornerRadius = 10
            catCell.layer.borderColor = UIColor.lightText.cgColor
            catCell.layer.borderWidth = 0.5
            return catCell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
            let cellPath = storeItems[indexPath.item]
           
            cell.model = cellPath
            cell.Item_ImgView.setImage(urlStr: cellPath.image)
            cell.titleLbl.text = cellPath.title
            cell.updateWishlist()
            cell.layer.cornerRadius = 10
            cell.layer.borderColor = UIColor.lightText.cgColor
            cell.layer.borderWidth = 0.5
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == sliderCV {
            let cellWidth = collectionView.bounds.width
            let cellHeight : CGFloat = collectionView.bounds.height
            return CGSize(width: cellWidth, height: cellHeight)
            
        } else if collectionView == offersCV {
            
            let cellWidth = collectionView.bounds.width
            let cellHeight : CGFloat = collectionView.bounds.height
            return CGSize(width: cellWidth, height: cellHeight)
            
        } else {
            
            let leftAndRightPaddings: CGFloat = 10
            let numberOfItemsPerRow: CGFloat = 2.0
                
            let width = (collectionView.frame.width-leftAndRightPaddings)/numberOfItemsPerRow
            return CGSize(width: width, height: width)

        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCV || collectionView == trendyCV {
            SelectedItem.itemSelected = storeItems[indexPath.item]
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "ProdcutDetailsVC") as! ProdcutDetailsVC
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    
    
}




struct ItemDetails {
    static let itemDesrciptArr:[String] = ["As in handbags, the double ring and bar design defines the wallet shape, highlighting the front flap closure which is tucked inside the hardware. Completed with an organizational interior, the black leather wallet features a detachable chain.", "All products are made with carefully selected materials. Please handle with care for longer product life.","Protect from direct light, heat and rain. Should it become wet, dry it immediately with a soft cloth", "Store in the provided flannel bag or box","Clean with a soft, dry cloth"]
  
    static let shippingInfoArr:[String] = ["Pre-order, Made to Order and DIY items will ship on the estimated date noted on the product description page. These items will ship through Premium Express once they become available.", "Returns may be made by mail or in store. The return window for online purchases is 30 days (10 days in the case of beauty items) from the date of delivery. You may return products by mail using the complimentary prepaid return label included with your order, and following the return instructions provided in your digital invoice."]
    
    static let paymentInfoArr:[String] = ["We accepts the following forms of payment for online purchases.","PayPal may not be used to purchase Made to Order Décor or DIY items.", "The full transaction value will be charged to your credit card after we have verified your card details, received credit authorisation, confirmed availability and prepared your order for shipping. For Made To Order, DIY, personalised and selected Décor products, payment will be taken at the time the order is placed."]
    
    
    
}


struct SelectedItem {
    
    
    static var itemSelected = ProductStore()
}
