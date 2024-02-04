//
//  ProductListViewModel.swift
//  BagzzDemoApp
//
//  Created by Gopu on 05/02/24.
//

import Foundation

class View_Model {
    
    var updateResponse: ((String) -> Void)?
    var isLoading: ((Bool) -> Void)?
    var didFetchList: ((ProductListResponse) -> Void)?
    var didFetchTestData: ((GetTestResponse) -> Void)?
    var didFetchPostData: ((GetTestResponseElement) -> Void)?

//    var updateToken:((TokenResponse)->Void)?
    
    // Fetching Characters List
    func fetch_Characters_List() {
        if reach.isConnectedToNetwork() {
        self.isLoading?(true)
            ApiService.callPost(url: ClientInterface.productListUrl, params: "", methodType: "GET", tag: "List", finish: finishPost)

        } else {
        self.updateResponse?("Check Internet Connection")

        }
        
        
    }
    
    func fetchTestUserList() {
        if reach.isConnectedToNetwork() {
        self.isLoading?(true)
            ApiService.callPost(url: ClientInterface.testUrl, params: "", methodType: "GET", tag: "Test", finish: finishPost)

        } else {
        self.updateResponse?("Check Internet Connection")

        }
        
        
    }
    
    func postTestUser(userInd:Int,textValue:String) {
        if reach.isConnectedToNetwork() {
        self.isLoading?(true)
            let details = ["id":userInd, "Column 1" :textValue ] as [String:Any]
        print("params=\(details)")
            ApiService.callPostToken(url: ClientInterface.testUrl, params: details, methodType: "POST", tag: "TestPost", finish: finishPost)

        } else {
        self.updateResponse?("Check Internet Connection")

        }
        
        
    }
    
//    func putUser(userInd:Int,textValue:String) {
//        if reach.isConnectedToNetwork() {
//        self.isLoading?(true)
//            let details = ["id":userInd, "Column 1" :textValue ] as [String:Any]
//        
//            ApiService.callPost(url: ClientInterface.testUrl, params: details, methodType: "POST", tag: "TestPost", finish: finishPost)
//
//        } else {
//        self.updateResponse?("Check Internet Connection")
//
//        }
//        
//        
//    }
    
   
   
 
  
        // MARK : Parsing API Response
    func finishPost (message:String, data:Data? , tag: String) -> Void {
                    
        self.isLoading?(false)
        
   
        if tag == "List" {
            
            do {
                if let jsonData = data {
                    let parsedData = try JSONDecoder().decode(ProductListResponse.self, from: jsonData)
                    print(parsedData)
                    self.didFetchList?(parsedData)
                    
                }
                
            } catch {
                print("Parse Error: \(error)")
                self.updateResponse?("Unable to fetch")
                
            }
        } else if tag == "TestPost" {
            
            do {
                
                if let jsonData = data {
                    
                    let parsedData = try JSONDecoder().decode(GetTestResponseElement.self, from: jsonData)
                    print(parsedData)
                    fetchTestUserList()
                    
                }
                
            } catch {
                print("Parse Error: \(error)")
                self.updateResponse?("Unable to fetch List Data")
                
            }
            
            
            
        } else if tag == "Test" {
            
            do {
                
                if let jsonData = data {
                    
                    let parsedData = try JSONDecoder().decode(GetTestResponse.self, from: jsonData)
                    print(parsedData)
                    self.didFetchTestData?(parsedData)
                    
                }
                
            } catch {
                print("Parse Error: \(error)")
                self.updateResponse?("Unable to fetch")
                
            }
            
            
            
        }
        
                    
    }
        

}
