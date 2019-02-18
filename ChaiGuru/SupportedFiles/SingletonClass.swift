//
//  SingletonClass.swift
//  ChaiGuru
//
//  Created by phanindhra on 2/10/19.
//  Copyright © 2019 phanindhra. All rights reserved.
//

import Foundation
import UIKit

extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    
    public class func once(token: String, block:()->Void) {
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        if _onceTracker.contains(token){
            return
        }
        _onceTracker.append(token)
        block()
    }
    
}

class SingletonClass{
    
    class var sharedInstance : SingletonClass {
        
        struct Static {
            static var instance : SingletonClass? = nil
        }
        
        DispatchQueue.once(token:"com.chaiguru.app",block: {
            Static.instance = SingletonClass()
        })
        
        return Static.instance!
        
    }
    
    
    var isCheckAddBtnClicked : Bool = false
    var chaiGuruDetailsDict : NSDictionary!
    
}
