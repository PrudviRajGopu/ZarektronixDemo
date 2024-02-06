//
//  SearchProductCell.swift
//  ZerktronixDemoApp
//
//  Created by Gopu on 03/02/24.
//

import UIKit

class SearchProductCell: UITableViewCell {

    @IBOutlet weak var productDescrptLbl: UILabel!
    
    @IBOutlet weak var productImgView: UIImageView!
    
    @IBOutlet weak var dataView: UIView!
    
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var productTitleLbl: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
    func updateCell(model:ProductListResponseElement) {
        
        productTitleLbl.text = model.title
        productDescrptLbl.text = model.description
        priceLbl.text = "\(model.price)"
        if model.image.isEmpty == false {
            productImgView.setImage(urlStr: model.image)
            productImgView.contentMode = .scaleAspectFill
        } else {
            productImgView.contentMode = .scaleAspectFit

        }
        
        
        dataView.layer.cornerRadius = 10
        
        
        
        
    }

}
