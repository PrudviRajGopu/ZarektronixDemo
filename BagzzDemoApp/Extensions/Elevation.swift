//
//  Elevation.swift
//  ZerktronixDemoApp
//
//  Created by Gopu on 04/02/24.
//

import Foundation
import UIKit


protocol MaterialView {
   func elevate(elevation: Double)
}
extension UIView: MaterialView {
   func elevate(elevation: Double) {
      self.layer.masksToBounds = false
      self.layer.shadowColor = UIColor.black.cgColor
      self.layer.shadowOffset = CGSize(width: 0, height: elevation)
      self.layer.shadowRadius = CGFloat(elevation)
      self.layer.shadowOpacity = 0.24
      if elevation >= 0.0 {
       self.layer.shadowRadius = abs(CGFloat(elevation))
       } else {
       self.layer.shadowRadius = abs(CGFloat(elevation))
       }
    }
}


extension UITableView {
    func reloadWithAnimation() {
        self.reloadData()
        let tableViewHeight = self.bounds.size.height
        let cells = self.visibleCells
        var delayCounter = 0
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        for cell in cells {
            UIView.animate(withDuration: 1.6, delay: 0.08 * Double(delayCounter),usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
    
   
}

extension UIColor {
   static let baseColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
    static let button_Clr = UIColor(red: 255/255, green: 149/255, blue: 5/255, alpha: 1)
    static let baseColor3 = UIColor(red: 226/255, green: 113/255, blue: 29/255, alpha: 1)
    static let subTitleColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)
    static let fontColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}




