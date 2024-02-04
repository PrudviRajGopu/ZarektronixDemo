//
//  APIService.swift
//  BagzzDemoApp
//
//  Created by Gopu on 05/02/24.
//


import Foundation
import UIKit

typealias Parameters = [String: String]


class ApiService: NSObject {
    
    static func getPostString(params:[String:Any]) -> String {
        var data = [String]()
        for(key, value) in params {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
    
    
    
    static func callPost(url:String, params: Any ,methodType: String, tag : String ,  finish: @escaping ((message:String, data:Data?, tag : String)) -> Void) {
        
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = methodType
        
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let body = NSMutableData()
        let boundary = generateBoundary()
        
        if methodType == "POST"  || methodType == "PUT" {
//            if params.isEmpty == false {
//                for (key, value) in params {
//                    body.appendString(string: "--\(boundary)\r\n")
//                    body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
//                    body.appendString(string: "\(value)\r\n")
//
//                }
//            }
//
//        body.appendString(string: "--\(boundary)--\r\n")
//        request.httpBody = body as Data
            
//            guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else { return }
//            request.httpBody = httpBody
            
        }
       
        DispatchQueue.global(qos: .background).async {
            var result:(message:String, data:Data? , tag : String) = (message: "Fail", data: nil , tag: tag)
            let session = URLSession.shared
            
            session.dataTask(with: request) { (data, response, error) in
            
                if let response = response {
                print(response)
                }
                
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                        print(json)
                        
                    } catch {
                        print(error)
                    }
                }
                
                DispatchQueue.main.async {
                    
                    if(error != nil){
                    result.message = "Fail Error not null : \(error.debugDescription)"
                    
                    } else {
                        result.message = "Success"
                        result.data = data
                        result.tag = tag
                        
                    }
                    
                    finish(result)
                    
                    
                }
                
                }.resume()
            
        }
    }
    
    static func callPostToken(url:String, params: Any ,methodType: String, tag : String ,  finish: @escaping ((message:String, data:Data?, tag : String)) -> Void){
        
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = methodType
//        let token = UserVaribales.token
//        print("token = \(UserVaribales.token)")
        request.httpMethod = methodType

//        request.addValue("Bearer ", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        
        if methodType == "POST"  || methodType == "PUT" {
            
            guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else { return }
            request.httpBody = httpBody
            
        }
        DispatchQueue.global(qos: .background).async {
        var result:(message:String, data:Data? , tag : String) = (message: "Fail", data: nil , tag: tag)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
        
        if let response = response {
            print(response)
        }
                
        if let data = data {
            do {
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            print(json)
                        
            } catch {
            print(error)
            }
            
        }
                
        DispatchQueue.main.async {
            if(error != nil){
            result.message = "Fail Error not null : \(error.debugDescription)"
            
            } else {
            result.message = "Success"
            result.data = data
            result.tag = tag
                        
            }
            finish(result)
                    
            }
                
            }.resume()
            
        }
    }
    
    static func postCallStr(url:String, params: [String:String] ,methodType: String, tag : String ,  finish: @escaping ((message:String, data:Data?, tag : String)) -> Void) {
        
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = methodType
        
//        let token = UserVaribales.token
//        print("token = \(UserVaribales.token)")
        
        request.httpMethod = methodType
        let body = NSMutableData()
        let boundary = generateBoundary()

//        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Accept")
        if methodType == "POST"  || methodType == "PUT" {
            
            if params.isEmpty == false {
                for (key, value) in params {
                    body.appendString(string: "--\(boundary)\r\n")
                    body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                    body.appendString(string: "\(value)\r\n")

                }
            }

        body.appendString(string: "--\(boundary)--\r\n")
        request.httpBody = body as Data
        

        }
         
        DispatchQueue.global(qos: .background).async {
            var result:(message:String, data:Data? , tag : String) = (message: "Fail", data: nil , tag: tag)
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                   
                if let data = data {
                do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print(json)
                           
                } catch {
                    print(error)
                }
                   
                }
                   
                DispatchQueue.main.async {
                    if(error != nil) {
                        result.message = "Fail Error not null : \(error.debugDescription)"
                   
                    } else {
                        result.message = "Success"
                        result.data = data
                        result.tag = tag
                    }
                    finish(result)
                       
                       
                   }
                   
                   }.resume()
               
           }
       }
    
    
    
    static func uploadMultipleIMGwithParam(parameters : [String : String]?,imageKey:[String]  , imgArr:[Data],  methodType : String , url :String, tag : String  ,finish: @escaping ((message:String, data:Data?, tag : String)) -> Void){

        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = methodType

        let boundary = generateBoundary()
        let body = NSMutableData()
        let timeStamp = currentTimeInMilliSeconds()
//        let token = UserVaribales.token
//        print("token = \(token)")
        
//        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Accept")
        if methodType == "POST"  || methodType == "PUT" {
        if parameters != nil {
            for (key, value) in parameters! {
            body.appendString(string: "--\(boundary)\r\n")
            body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString(string: "\(value)\r\n")

            }
        }
            
            for (index,Img) in imgArr.enumerated() {
                let filename = "\(timeStamp!)\(index)image.jpeg"
                let mimetype = "image/jpeg"
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(imageKey[index])\"; filename=\"\(filename)\"\r\n")
                body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
                body.append(Img )
                body.appendString(string: "\r\n")

                print("filename = \(filename)")
                print("mimetype = \(mimetype)")
                print("imageKey = \(imageKey[index])")
                
            }
            body.appendString(string: "--\(boundary)--\r\n")
            request.httpBody = body as Data
            
        }


        DispatchQueue.global(qos: .background).async {
            var result:(message:String, data:Data? , tag : String) = (message: "Fail", data: nil , tag: tag)
            
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in

            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print(json)

                } catch {
                print("url error \(error)")

                }

            }
            DispatchQueue.main.async {
                if (error != nil) {
                result.message = "Fail Error not null : \(error.debugDescription)"

                } else {
                let httpResponse = response as? HTTPURLResponse
                result.message = String(describing:httpResponse!.statusCode)
                result.data = data
                result.tag = tag
                    
                }
                finish(result)

                }
                
            }.resume()
                
        }


    }
    
    static func generateBoundary() -> String {
       return "Boundary-\(NSUUID().uuidString)"
   }

   static func currentTimeInMilliSeconds()-> Int? {
        let currentDate = Date()
        let since1970 = currentDate.timeIntervalSince1970
        
        return Int(since1970 * 1000)
    }
       

}

extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
        
    }
    
    
}
