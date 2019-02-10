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

class Connectivity {
    
    class func isNetworkAvailable() -> Bool {
        return ((Reachability()?.isReachable)!)
    }
    
    
}



struct APIRequest {
    
    var progressHud = MBProgressHUD()
    
    static var shareDInstance = APIRequest()
    
    
    
    func callApiRequestResponse(methodName : String, postString : String,postInputStream : AnyObject,requestType : String,SuccessResponse : @escaping CompletionHandlerBlock, failureResponse : @escaping failreResponseBlock) {
    
        
        if Connectivity.isNetworkAvailable() {
            
            //Network is available
            
            
            
            let apiRequest = DispatchQueue.init(label: "com.chaiguru.app")
            
            apiRequest.sync {
                
                
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
            
         }else{
            
            //Network is Not available
            
            
            
        }
     
        
      
        
    }
    
    //MARK: Show MBProgress Hud function
    
    mutating func MBProgress(view : UIView, message : String){
        
        progressHud = MBProgressHUD.showAdded(to: view, animated: true)
        progressHud.label.text = message
        
    }
    
    //MARK: Hide MBProgress Hud function
    
    func hideProgreesHUD() {
        
       progressHud.hide(animated: true)
       progressHud.isHidden = true
        
    }
    
}
