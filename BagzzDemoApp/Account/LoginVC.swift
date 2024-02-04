//
//  LoginVC.swift
//  ZerktronixDemoApp
//
//  Created by Gopu on 04/02/24.
//

import UIKit
import SideMenuSwift

class LoginVC: UIViewController {
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var logoImgView: UIImageView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var singUpBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
    }
    
    func setUpView() {
        
        logoImgView.layer.cornerRadius = 100
        emailTF.layer.cornerRadius = 10
        passwordTF.layer.cornerRadius = 10
        loginBtn.layer.cornerRadius = 10
        singUpBtn.layer.cornerRadius = 10
        
        emailTF.text = "first@gmail.com"
        passwordTF.text = "Abcd1234"

        
    }
    
    
    @IBAction func secureBtnAxn(_ sender: UIButton) {
        
        /// tag = 0 == secured, tag = 1 == unsecured
        
        if sender.tag == 0 {
            sender.tag = 1
            passwordTF.isSecureTextEntry = false
            sender.setImage(UIImage(named: "openeye"), for: .normal)

        } else {
            sender.tag = 0
            passwordTF.isSecureTextEntry = true
            sender.setImage(UIImage(named: "closedeye"), for: .normal)

        }
    
        
    }
    
    @IBAction func loginBtnAxn(_ sender: UIButton) {
        
        if emailTF.text == "" || passwordTF.text == "" {
            self.view.makeToast("Enter all Details")
            self.loginBtn.shake()
        } else if emailTF.text?.isValidEmail() == false {
            self.view.makeToast("Enter a valid Email")
            self.emailTF.shake()

        } else if self.passwordTF.text?.isValidPassword() == false {
            self.view.makeToast("Enter a valid Password")
            self.passwordTF.shake()
        } else {
            guard let result = DataManager.shared.checkUser(email: emailTF.text!, passWord: passwordTF.text!) else {
                self.view.makeToast("Check Login Credentials")

                return
                
            }
            
            
            let currentUser = result.convertToJSON()

            print("currentResult = \(result)")
            print("currentUser = \(currentUser)")


             Preferrences.isLoggedIn(status: true)
             Preferrences.setRememberMe(status: true)
            Preferrences.setFirstName(type: "\(currentUser["firstName"] ?? "")")
            Preferrences.setLastName(type: "\(currentUser["lastName"] ?? "")")
             Preferrences.setUserEmail(type: "\(currentUser["email"] ?? "")")
             Preferrences.setUserID(type: "\(currentUser["userId"] ?? "")" )
            Preferrences.setUserPass(type: "\(currentUser["password"] ?? "")")
            let userid = Preferrences.getUserID()
            print("userid = \(userid)")

                self.view.makeToast("Login Success")
             
            let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SideMenuController") as! SideMenuController
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                    self.navigationController?.pushViewController(VC, animated: true)
                    
                })
            }
        
    }
    
    
    
    @IBAction func SignUpBtn_Axn(_ sender: UIButton) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
         self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    

}
