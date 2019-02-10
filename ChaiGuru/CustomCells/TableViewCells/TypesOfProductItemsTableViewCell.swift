//
//  TypesOfProductItemsTableViewCell.swift
//  ChaiGuru
//
//  Created by phanindhra on 2/8/19.
//  Copyright © 2019 phanindhra. All rights reserved.
//

import UIKit

class TypesOfProductItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var productItemsCollectionView : UICollectionView!
    
    var isCheckBtnAdd = false
    
    var indexpathObj = IndexPath()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func getDataFromHomeScreen(indexpath : IndexPath){
        
        print("CellStyle",indexpath)
        
    }
    
    

}


extension TypesOfProductItemsTableViewCell : UICollectionViewDataSource,UICollectionViewDelegate{
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypesOfProductCollectionViewCell", for: indexPath) as! TypesOfProductCollectionViewCell
        
       
        
        collectionCell.btnOfAdd.addTarget(self, action: #selector(btnOfAdd(_:)), for: .touchUpInside)
        
        collectionCell.btnOfAdd.tag = indexPath.row
        
      
        if isCheckBtnAdd == false{
            
           
            
            collectionCell.viewOfAdd.isHidden = false
            collectionCell.viewOfPlusandMinus.isHidden = true
            
            
        }else{
            
            isCheckBtnAdd = false
         
            collectionCell.viewOfAdd.isHidden = true
            collectionCell.viewOfPlusandMinus.isHidden = false
            
        }
        
        
        
        return collectionCell
    }
    
    
    @objc func btnOfAdd(_ sender : Any){
        
        print("collection",sender)
        
        indexpathObj.row = (sender as AnyObject).tag
        
       isCheckBtnAdd = true
        
        productItemsCollectionView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        print("collection",indexPath)
        
    }
    
    
    
}
