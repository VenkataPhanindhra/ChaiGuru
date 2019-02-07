//
//  File.swift
//  ChaiGuru
//
//  Created by phanindhra on 2/6/19.
//  Copyright © 2019 phanindhra. All rights reserved.
//

import Foundation
import UIKit

class UserDefaultStored : NSObject{
    
//    class var userId: String {
//
//        get {
//            // Get the standard UserDefaults as "defaults"
//            let defaults = UserDefaults.standard
//
//            // Makes the "userId" variable whatever the saved value for "userId" is
//            return defaults.string(forKey: "userId") ?? ""
//        }
//        set (newValue) {
//            // Get the standard UserDefaults as "defaults"
//            let defaults = UserDefaults.standard
//
//            // Saves what the "userId" variable was just set to as the saved value for "userId"
//            defaults.set(newValue, forKey: "userId")
//        }
//        
//    }
    
    class var userId: String! {

        get{
            if let did = UserDefaults.standard.object(forKey: "userId") {
                return (did as! String)
            }
            return nil
        }
        set(newVal){
            UserDefaults.standard.set(newVal, forKey: "userId")
        }

    }
    
  
    class var Name: String! {
        
        get{
            if let did = UserDefaults.standard.object(forKey: "Name") {
                return (did as! String)
            }
            return nil
        }
        set(newVal){
            UserDefaults.standard.set(newVal, forKey: "Name")
        }
        
    }
    
    
    class var Email: String! {
        
        get{
            if let did = UserDefaults.standard.object(forKey: "Email") {
                return (did as! String)
            }
            return nil
        }
        set(newVal){
            UserDefaults.standard.set(newVal, forKey: "Email")
        }
        
    }
    
    class var Password: String! {
        
        get{
            if let did = UserDefaults.standard.object(forKey: "Password") {
                return (did as! String)
            }
            return nil
        }
        set(newVal){
            UserDefaults.standard.set(newVal, forKey: "Password")
        }
        
    }
    
    
}


