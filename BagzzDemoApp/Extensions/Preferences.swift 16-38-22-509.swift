//
//  Preferences.swift
//  ZerktronixDemoApp
//
//  Created by Gopu on 04/02/24.
//

import Foundation

class Preferrences {

  
    class func setFCMToken(type: String) {
        UserDefaults.standard.set(type, forKey: "FCMToken")
    }


    class func getFCMToken() -> String {
    if let type: String = UserDefaults.standard.string(forKey: "FCMToken") {
    return type

    } else {
    return ""
    }

    }
    
    class func setDefaultStoreId(type: String) {
        UserDefaults.standard.set(type, forKey: "Store_id")
    }


    class func getDefaultStoreId() -> String {
    if let type: String = UserDefaults.standard.string(forKey: "Store_id") {
    return type

    } else {
    return ""
    }

    }
    
    class func setUserDOB(type: String) {
        UserDefaults.standard.set(type, forKey: "User_DOB")
    }


    class func getUserDOB() -> String {
    if let type: String = UserDefaults.standard.string(forKey: "User_DOB") {
    return type

    } else {
    return ""
    }

    }
    
    
    class func setUserID(type: String) {
        
        UserDefaults.standard.set(type, forKey: "userID")
    }


    class func getUserID() -> String {
    if let type: String = UserDefaults.standard.string(forKey: "userID") {
    return type

    } else {
    return ""
    }

    }
    
    class func setDeviceID(type: String) {
        
        UserDefaults.standard.set(type, forKey: "DeviceId")
    }


    class func getDeviceID() -> String {
        if let type: String = UserDefaults.standard.string(forKey: "DeviceId") {
            return type
            
        } else {
            return ""
        }

    }
    
    class func setAccessToken(type: String) {
        
        UserDefaults.standard.set(type, forKey: "User_Token")
    }


    class func getAccessToken() -> String {
    if let type: String = UserDefaults.standard.string(forKey: "User_Token") {
    return type

    } else {
    return ""
    }

    }
    
    
    
    class func setRewards(type: String) {
        
        UserDefaults.standard.set(type, forKey: "Rewards")
    }


    class func getRewards() -> String {
    if let type: String = UserDefaults.standard.string(forKey: "Rewards") {
    return type

    } else {
    return ""
    }

    }
    
    class func setWallet(type: String) {
        
        UserDefaults.standard.set(type, forKey: "Wallet")
    }


    class func getWallet() -> String {
    if let type: String = UserDefaults.standard.string(forKey: "Wallet") {
    return type

    } else {
    return ""
    }

    }
    
    class func setLocationID(type: String) {
        
        UserDefaults.standard.set(type, forKey: "Location_ID")
    }


    class func getLocationID() -> String {
    if let type: String = UserDefaults.standard.string(forKey: "Location_ID") {
    return type

    } else {
    return ""
    }

    }

    class func setIPAddress(type: String) {
        UserDefaults.standard.set(type, forKey: "userIP")
    }


    class func getIPAddress() -> String {

    if let type: String = UserDefaults.standard.string(forKey: "userIP") {
    return type

    } else {
    return ""
    }

    }
    
   
    class func setUserLat(type: String) {
        UserDefaults.standard.set(type, forKey: "User_Lat")
    }


    class func getUserLat() -> String {

    if let type: String = UserDefaults.standard.string(forKey: "User_Lat") {
    return type

    } else {
    return ""
    }

    }
    
    class func setUserLong(type: String) {
        UserDefaults.standard.set(type, forKey: "User_Long")
    }


    class func getUserLong() -> String {

    if let type: String = UserDefaults.standard.string(forKey: "User_Long") {
    return type

    } else {
    return ""
    }

    }
    
    
    class func setPincode(type: String) {
        UserDefaults.standard.set(type, forKey: "pincode")
    }


    class func getPincode() -> String {

    if let type: String = UserDefaults.standard.string(forKey: "pincode") {
    return type

    } else {
    return ""
    }

    }
    class func setUserLoc(type: String) {
        UserDefaults.standard.set(type, forKey: "User_Loc")
    }


    class func getUserLoc() -> String {

    if let type: String = UserDefaults.standard.string(forKey: "User_Loc") {
    return type

    } else {
    return ""
    }

    }

    class func setSocietyId(type: String) {
        UserDefaults.standard.set(type, forKey: "SocietyId")
    }


    class func getSocietyId() -> String {

    if let type: String = UserDefaults.standard.string(forKey: "SocietyId") {
    return type

    } else {
    return ""
    }

    }
    class func setUserAddress(type: String) {
        UserDefaults.standard.set(type, forKey: "User_Address")
    }


    class func getUserAddress() -> String {

    if let type: String = UserDefaults.standard.string(forKey: "User_Address") {
    return type

    } else {
    return ""
    }

    }

    class func setFirstName(type: String) {
        UserDefaults.standard.set(type, forKey: "FirstName")
    }


    class func getFirstName() -> String {

    if let type: String = UserDefaults.standard.string(forKey: "FirstName") {
    return type

    } else {
    return ""
    }

    }
    class func setLastName(type: String) {
        UserDefaults.standard.set(type, forKey: "LastName")
    }


    class func getLastName() -> String {

    if let type: String = UserDefaults.standard.string(forKey: "LastName") {
    return type

    } else {
    return ""
    }

    }


    class func setUserIMG(type: String) {

    UserDefaults.standard.set(type, forKey: "user_Img")
    }

    class func getUserIMG() -> String {

    if let type: String = UserDefaults.standard.string(forKey: "user_Img") {
    return type

    } else {
    return ""
    }
    }

    class func setUserMobile(type: String) {
            UserDefaults.standard.set(type, forKey: "user_Mobile")
        }


    class func getUserMobile() -> String {

        if let type: String = UserDefaults.standard.string(forKey: "user_Mobile") {
                return type
            } else {
                return ""
            }
        }

    class func setUserEmail(type: String) {
            UserDefaults.standard.set(type, forKey: "user_email")
        }


    class func getUserEmail() -> String {

        if let type: String = UserDefaults.standard.string(forKey: "user_email") {
                return type
            } else {
                return ""
            }
        }

    class func setUserPass(type: String) {
        UserDefaults.standard.set(type, forKey: "user_pass")
    }

    class func getUserPass() -> String {
        if let type: String = UserDefaults.standard.string(forKey: "user_pass") {
            return type
        } else {
            return ""
        }
    }

    class func setRememberMe(status: Bool) {
        UserDefaults.standard.set(status, forKey: "login_status")
    }



    class func getRememberMe() -> Bool {
        let status: Bool = UserDefaults.standard.bool(forKey: "login_status")
        return status
    }
    
    
    class func setFarmerStatus(status: Int) {
        UserDefaults.standard.set(status, forKey: "farmer_Status")
    }



    class func getFarmerStatus() -> Int {
        let status:Int = UserDefaults.standard.integer(forKey: "farmer_Status")
        return status
    }
    

    class func setInstalled(status: Bool) {
        UserDefaults.standard.set(status, forKey: "is_installed")
    }



    class func getInstalled() -> Bool {
        let status: Bool = UserDefaults.standard.bool(forKey: "is_installed")
        return status
    }
    
    class func setTokenGenerated(status: Bool) {
        UserDefaults.standard.set(status, forKey: "Token_Generated")
    }



    class func getTokenGenerated() -> Bool {
        let status: Bool = UserDefaults.standard.bool(forKey: "Token_Generated")
        return status
    }

    class func isLoggedIn(status: Bool) {
           UserDefaults.standard.set(status, forKey: "is_Logged")
       }



       class func getLoggedIn() -> Bool {
           let status: Bool = UserDefaults.standard.bool(forKey: "is_Logged")
           return status
       }

        class func clearPreference () {
            UserDefaults.standard.removeObject(forKey: "user_name")
            UserDefaults.standard.removeObject(forKey: "password")
            UserDefaults.standard.removeObject(forKey: "isUserLogin")
            UserDefaults.standard.removeObject(forKey: "profile_id")
            UserDefaults.standard.removeObject(forKey: "first_name")
            UserDefaults.standard.removeObject(forKey: "last_name")
        }



        

    }
    
