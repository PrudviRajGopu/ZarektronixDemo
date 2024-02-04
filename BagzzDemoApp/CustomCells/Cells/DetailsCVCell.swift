//
//  DetailsCVCell.swift
//  BagzzDemoApp
//
//  Created by Gopu on 05/02/24.
//

import UIKit

class DetailsCVCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var dataView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.layer.cornerRadius = 5
    }
    
    
    override var isSelected: Bool {
      didSet {
        
       self.titleLbl.textColor = isSelected ? UIColor.white : UIColor.black
          self.contentView.backgroundColor = isSelected ? UIColor.black : UIColor.white
         
      }
    }
    
}
