//
//  Extension.swift
//  ChaiGuru
//
//  Created by phanindhra on 2/7/19.
//  Copyright © 2019 phanindhra. All rights reserved.
//

import UIKit

extension NSDictionary{
    
    func chaiGuruObject(forKey : String) -> String{
        
        if self.object(forKey: forKey) != nil {
                return String(describing:self.object(forKey: forKey)!)
            }else{
                return ""
            }
        
    }
    
    
    
    
}
