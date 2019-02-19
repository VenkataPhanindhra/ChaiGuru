//
//  TypesOfProductCollectionViewCell.swift
//  ChaiGuru
//
//  Created by phanindhra on 2/8/19.
//  Copyright © 2019 phanindhra. All rights reserved.
//

import UIKit

class TypesOfProductCollectionViewCell: UICollectionViewCell {
  
    @IBOutlet weak var imgOfCollections : UIImageView!
    @IBOutlet weak var lblOfProductName : UILabel!
    @IBOutlet weak var lblOfProductCost : UILabel!
    
    @IBOutlet weak var viewOfAdd : UIView!
    @IBOutlet weak var btnOfAdd : UIButton!
    
    @IBOutlet weak var viewOfPlusandMinus : UIView!
    @IBOutlet weak var plusBtn : UIButton!
    @IBOutlet weak var minusBtn : UIButton!
    @IBOutlet weak var lblOfTotalItems : UILabel!
    
    var tableViewIndexPath : IndexPath!
    
    @IBAction func addBtnClicked(_ sender : UIButton){
        
//        print(tableViewIndexPath)
        
    }
    
    
}
