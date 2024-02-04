//
//  SignUpVC.swift
//  ZerktronixDemoApp
//
//  Created by Gopu on 04/02/24.
//

import UIKit
import CoreData

var users = [UserInfo]()
var storeItems = [ProductStore]()
var cartList = [CartItems]()
var wishListItems = [WishList]()


class SignUpVC: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    
    
    @IBOutlet weak var confirmPassTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var lastNameTF: UITextField!
    
    @IBOutlet weak var firstNameTF: UITextField!
    
    
    @IBOutlet weak var signUpBtn: UIButton!
   
    
    var userID = "1"
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {

//        DataManager.shared.deleteAllUsers()

        signUpBtn.layer.cornerRadius = 10
        emailTF.layer.cornerRadius = 10
        passwordTF.layer.cornerRadius = 10
        lastNameTF.layer.cornerRadius = 10
        firstNameTF.layer.cornerRadius = 10
        confirmPassTF.layer.cornerRadius = 10
        users = DataManager.shared.users()
        if users.isEmpty{
            userID = "1"
        } else {
            userID = "\(users.count + 1)"
        }

    }

    @IBAction func backBtn_Axn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func passwordEyeBtnAxn(_ sender: UIButton) {
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
    
    @IBAction func confirmPassBtnAxn(_ sender: UIButton) {
        if sender.tag == 0 {
            sender.tag = 1
            confirmPassTF.isSecureTextEntry = false
            sender.setImage(UIImage(named: "openeye"), for: .normal)

        } else {
            sender.tag = 0
            confirmPassTF.isSecureTextEntry = true
            sender.setImage(UIImage(named: "closedeye"), for: .normal)

        }
    
    }
    
    @IBAction func signUpBtnAxn(_ sender: UIButton) {
        
        if emailTF.text == "" || passwordTF.text == "" || firstNameTF.text == "" || lastNameTF.text == "" {
            self.view.makeToast("Enter all Details")
            self.signUpBtn.shake()
        } else if emailTF.text?.isValidEmail() == false {
            self.view.makeToast("Enter a valid Email")
            self.emailTF.shake()

        } else if self.passwordTF.text?.isValidPassword() == false {
            self.view.makeToast("Enter a valid Password")
            self.passwordTF.shake()
        } else if passwordTF.text != confirmPassTF.text {
            self.view.makeToast("Confirm Password mismatch")
            self.confirmPassTF.shake()

        } else {
            
            let user = DataManager.shared.user(email: emailTF.text!, fName: firstNameTF.text!, lName: lastNameTF.text!, pass: passwordTF.text!, userId: userID)
            if users.contains(user) {
                self.view.makeToast("User already registered. Try Login")

            } else {
                users.append(user)
                DataManager.shared.save()
                print("usersNow=\(DataManager.shared.users())")
                print("users_Now=\(users)")

                self.view.makeToast("Login Success")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                    self.navigationController?.popViewController(animated: true)

                })
            }
           
        
        }
    }
    
}
