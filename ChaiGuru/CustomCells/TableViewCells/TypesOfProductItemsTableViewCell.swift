//
//  TypesOfProductItemsTableViewCell.swift
//  ChaiGuru
//
//  Created by phanindhra on 2/8/19.
//  Copyright © 2019 phanindhra. All rights reserved.
//

import UIKit
import SDWebImage

protocol NavigateToProductDetails : class {
    func showProductItemDetails()
}

class TypesOfProductItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var productItemsCollectionView : UICollectionView!
    
    var isCheckBtnAdd = false
    
    var arrOfCollectioViewProductData = NSMutableArray()
    
    weak var delegateObj : NavigateToProductDetails!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func getDataFromHomeScreen(arrayOfProducts : NSMutableArray){

       arrOfCollectioViewProductData.removeAllObjects()
        
       arrOfCollectioViewProductData = arrayOfProducts
        
        
        productItemsCollectionView.reloadData()
    }
    
    

}


extension TypesOfProductItemsTableViewCell : UICollectionViewDataSource,UICollectionViewDelegate{
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrOfCollectioViewProductData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypesOfProductCollectionViewCell", for: indexPath) as! TypesOfProductCollectionViewCell
        
       
        
        collectionCell.btnOfAdd.addTarget(self, action: #selector(btnOfAdd(_:)), for: .touchUpInside)
        
        let dictProductData = arrOfCollectioViewProductData[indexPath.row] as! NSDictionary
        
        collectionCell.lblOfProductName.text = dictProductData.chaiGuruObject(forKey: "p_name")
        collectionCell.lblOfProductCost.text = "₹" + dictProductData.chaiGuruObject(forKey: "p_price")
        
        
        DispatchQueue.main.async {
            
            let img = dictProductData.chaiGuruObject(forKey: "img")
            let constructOfImage = "http://3.1.5.235/assets/templateassets/images/chaiguru/boxes/"
            
            let finalImage = constructOfImage + img
            
            let url = URL.init(string: finalImage)
            
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            
            collectionCell.imgOfCollections.image = UIImage.init(data: data!)
            
//          collectionCell.imgOfCollections.sd_setImage(with: url, placeholderImage: UIImage())
            
        }
        
       
        
        return collectionCell
    }
    
    
    @objc func btnOfAdd(_ sender : Any){
//
//        print("collection",sender)
//
//      //  indexpathObj.row = (sender as AnyObject).tag
//
//       isCheckBtnAdd = true
//
//        productItemsCollectionView.reloadData()
        
        if delegateObj != nil{
            self.delegateObj.showProductItemDetails()
        }
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        

        
    }
    
    
    
}
