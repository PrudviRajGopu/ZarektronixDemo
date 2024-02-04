//
//  StringExt.swift
//  ZerktronixDemoApp
//
//  Created by Gopu on 04/02/24.
//

import Foundation
import UIKit


extension String {
  
    func fromUrltoImg()->UIImage {
        if let imgUrl = URL(string: self) {
            let data = try? Data(contentsOf: imgUrl)
            let image: UIImage = UIImage(data: data!)!
            return image
        } else {
            return UIImage(named: "package")!
        }
        
        
    }
    
    func isValidContact() -> Bool {
        let phoneNumberRegex = "^[6-9]\\d{9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidPhone = phoneTest.evaluate(with: self)
        return isValidPhone
  }

    func removeSpecialCharsFromString() -> String {
        let okayChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-=().!_,")
        return self.filter {okayChars.contains($0) }
    }

    func fiterPrice() -> String {
        let okayChars = Set("1234567890,.")
        return self.filter {okayChars.contains($0) }
    }
    func remove(word:String) -> String {
        return self.replacingOccurrences(of: word, with: "")
    }
    
    func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    func isValidPhone() -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        return NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: self)
    }
   
    func isValidPANCard() -> Bool{
        let regularExpression = "[A-Z]{5}[0-9]{4}[A-Z]{1}"
        return NSPredicate(format : "SELF MATCHES %@", regularExpression).evaluate(with: self)
    }
    
    func isValidGSTNumber() -> Bool{
        let regularExpression = "[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}"
           return NSPredicate(format : "SELF MATCHES %@", regularExpression).evaluate(with: self)
       }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: self)
    }

    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
    
    
    
   
    func getDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
//        dateFormatter.dateStyle = .short
        let convertedDate = dateFormatter.date(from: self)
        print("convertedDate = \(String(describing: convertedDate))")
        return convertedDate
    }
   
    func getTime() -> Date? {
       
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:MM:SS"
   //        dateFormatter.dateStyle = .short
        return dateFormatter.date(from: self) // replace Date String
      
    }
    

}


extension Date {
    
    func getOnlyDateString()-> String {
        let date = Date()
        let dateFormatter = DateFormatter()


        dateFormatter.dateFormat = "YYYY-MM-dd"
        let onlyDate = dateFormatter.string(from: date)

          print("onlyDate = \(onlyDate)")
        return onlyDate
    }
    func getCurrentTime()-> String {
         let date = Date()
         let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:MM:SS"
        let onlyTime = dateFormatter.string(from: date)
        print("onlyTime = \(onlyTime)")
        return onlyTime
    }
    func stripTime() -> Date {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let date = Calendar.current.date(from: components)
        return date!
    }
    func getComponents(dayString:UILabel,monthString:UILabel,yearString:UILabel) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day,.month,.year], from: self)
        if let day = components.day, let month = components.month, let year = components.year {
            dayString.text = String(day)
            monthString.text = String(month)
            yearString.text = String(year)
        }
    }

}


extension Data {
    
    func fileSize()->Double {
        let fileSize = Double(self.count / 1048576) //Convert in to MB
        print("Filesize_MB: ", fileSize)
        return fileSize
    }
    
}

extension UIImageView {
    func setImage(urlStr: String) {
        guard let imageURL = URL(string: urlStr) else { return }
       
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.image = image
            }
            
        }
    }
    func makeRounded() {
        self.layer.borderWidth = 0.5
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
}
