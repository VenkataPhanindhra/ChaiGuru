//
//  APIRequest.swift
//  ChaiGuru
//
//  Created by phanindhra on 2/7/19.
//  Copyright © 2019 phanindhra. All rights reserved.
//

import Foundation

typealias CompletionHandlerBlock = (_ dataOfResponse : AnyObject) -> Void
typealias failreResponseBlock = (_ statusNumber : Int ) -> Void

struct APIRequest {
    
    static var shareDInstance = APIRequest()
    
    
    func callApiRequestResponse(methodName : String, postString : String,postInputStream : AnyObject,requestType : String,SuccessResponse : @escaping CompletionHandlerBlock, failureResponse : @escaping failreResponseBlock) {
    
        
        
     
        
        guard let url = URL(string: String.init(format: "%@%@", ChaiguruConstants.requestURl,methodName))  else {
                print("Error: cannot create URL")
            return
        }
        
       
        
        let urlSessionConfig = URLSessionConfiguration.default
        let urlSession  = URLSession.init(configuration: urlSessionConfig)
        
        var urlRequest = URLRequest.init(url: url)
        
        urlRequest.httpMethod = requestType
        
        urlRequest.setValue("ASXCV@#$%", forHTTPHeaderField: "Auth-Token")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var postData = Data()
        
        do{
        
//            if postString is empty string than it is post type
            
        if postString == ""{
//            post
           
            postData = try JSONSerialization.data(withJSONObject: postInputStream, options: .prettyPrinted) as Data
            
            urlRequest.httpBody = postData
            
            
        }else{
            
//            get
            
        }
        
        
        
        
        let dataTask = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            
            
            guard error == nil else{
                
                return
            }
            
             let httpResponse = response as? HTTPURLResponse
                
                
                if httpResponse?.statusCode == 200{
                    
                    do{
                        
                        let dataResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                        
                        SuccessResponse(dataResponse as AnyObject)
                        
                    }catch{
                        
                    
                    }
                    
                    
                }else{
                    
                    failureResponse(httpResponse?.statusCode ?? 007)
                    
                }
                
                
           }
        
        dataTask.resume()
        
        }catch{
            
            
            
        }
        
        
    }
    
    
    
}
