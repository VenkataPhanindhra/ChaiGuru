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
    
    var singletonObj : SingletonClass!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        singletonObj = SingletonClass.sharedInstance
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func getDataFromHomeScreen(arrayOfProducts : NSMutableArray){

       arrOfCollectioViewProductData.removeAllObjects()
        
       arrOfCollectioViewProductData.addObjects(from: arrayOfProducts as! [Any])
        
        
        productItemsCollectionView.reloadData()
    }
    
    

}


extension TypesOfProductItemsTableViewCell : UICollectionViewDataSource,UICollectionViewDelegate{
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrOfCollectioViewProductData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypesOfProductCollectionViewCell", for: indexPath) as! TypesOfProductCollectionViewCell
        
       //collectionCell.tableViewIndexPath = indexPath
        
        collectionCell.btnOfAdd.tag = indexPath.row
        collectionCell.btnOfAdd.addTarget(self, action: #selector(btnOfAdd(_:)), for: .touchUpInside)
        
        
        
        let dictProductData = arrOfCollectioViewProductData[indexPath.row] as! NSDictionary
        
        collectionCell.lblOfProductName.text = dictProductData.chaiGuruObject(forKey: "p_name")
        collectionCell.lblOfProductCost.text = "₹ " + dictProductData.chaiGuruObject(forKey: "p_price")
        
        collectionCell.imgOfCollections.layer.cornerRadius = 8
        collectionCell.imgOfCollections.layer.masksToBounds = true
        
        
        
        DispatchQueue.main.async {
            
            let img = dictProductData.chaiGuruObject(forKey: "img6")
            let constructOfImage = "http://3.1.5.235/assets/templateassets/images/chaiguru/home/"
            
            let finalImage = constructOfImage + img
            
            collectionCell.imgOfCollections.sd_setImage(with: URL.init(string: finalImage), placeholderImage: UIImage.init(named: "LoginLogo"))
            
        }
        
        collectionCell.plusBtn.tag = indexPath.row
        collectionCell.minusBtn.tag = indexPath.row
        collectionCell.plusBtn.addTarget(self, action: #selector(incrementButtonClicked(_:)), for: .touchUpInside)
        collectionCell.minusBtn.addTarget(self, action: #selector(decrementBtnClicked(_:)), for: .touchUpInside)
        
        
        
       
        if singletonObj.ChaiGuruProductItemLists.contains(dictProductData){

            collectionCell.viewOfAdd.isHidden = true
            let id = dictProductData.chaiGuruObject(forKey: "p_id")
            
            
            for i in 0 ..< singletonObj.ProductItemCartLists.count{
                
                let product = singletonObj.ProductItemCartLists[i]
                
                if id == product.ItemProductId {
                   
                    collectionCell.lblOfTotalItems.text = "\(String(describing: product.NoOfItems!))"
                   
                    break
                }
                
            }
            
        }else{

           collectionCell.viewOfAdd.isHidden = false

        }
        
        
        
        return collectionCell
    }
    
    
    @objc func btnOfAdd(_ sender : UIButton){

      

        
        let dictProductData = arrOfCollectioViewProductData[sender.tag] as! NSDictionary
        
        singletonObj.ChaiGuruProductItemLists.add(dictProductData)
        
        
        var productsCartLists = ProductItemsAddedToCart()
        productsCartLists.NoOfItems = 1
        productsCartLists.ItemEachCost = dictProductData.chaiGuruObject(forKey: "p_price")
        productsCartLists.ItemProductId = dictProductData.chaiGuruObject(forKey: "p_id")
        productsCartLists.ItemName = dictProductData.chaiGuruObject(forKey: "p_name")
        productsCartLists.TotalCost = dictProductData.chaiGuruObject(forKey: "p_price")
        
        singletonObj.ProductItemCartLists.append(productsCartLists)
        
        productItemsCollectionView.reloadData()
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let dictObj = arrOfCollectioViewProductData[indexPath.row] as! NSDictionary
        
        singletonObj.chaiGuruDetailsDict = dictObj
        
        
        if delegateObj != nil{
            self.delegateObj.showProductItemDetails()
        }

    }
    
    
    @objc func incrementButtonClicked(_ sender : UIButton){
    
        let dictProductData = arrOfCollectioViewProductData[sender.tag] as! NSDictionary
        
        let id = dictProductData.chaiGuruObject(forKey: "p_id")
        
        let filterdArray = singletonObj.ProductItemCartLists.filter() { $0.ItemProductId == id }
        
        if filterdArray.count > 0{
            
            var listOfCartProduct = filterdArray[0]
            listOfCartProduct.NoOfItems += 1
            
            let floatValue = Float(listOfCartProduct.ItemEachCost)
            let totalValue = floatValue! * Float(listOfCartProduct.NoOfItems)
            
            listOfCartProduct.TotalCost = String(totalValue)
            
            singletonObj.ProductItemCartLists.remove(at: (find(objecToFind: listOfCartProduct.ItemProductId))!)
            
            singletonObj.ProductItemCartLists.append(listOfCartProduct)
            
        }
        
        productItemsCollectionView.reloadData()
        
    }
    
    @objc func decrementBtnClicked(_ sender : UIButton){
        
        let dictProductData = arrOfCollectioViewProductData[sender.tag] as! NSDictionary
        
        let id = dictProductData.chaiGuruObject(forKey: "p_id")
        
        let filterdArray = singletonObj.ProductItemCartLists.filter() { $0.ItemProductId == id }
        
        if filterdArray.count > 0{
            
            var listOfCartProduct = filterdArray[0]
            listOfCartProduct.NoOfItems -= 1
            
            let floatValue = Float(listOfCartProduct.ItemEachCost)
            let totalValue = floatValue! * Float(listOfCartProduct.NoOfItems)
            
            listOfCartProduct.TotalCost = String(totalValue)
            
            singletonObj.ProductItemCartLists.remove(at: (find(objecToFind: listOfCartProduct.ItemProductId))!)
            
            
            if listOfCartProduct.NoOfItems == 0{
                
               singletonObj.ChaiGuruProductItemLists.remove(dictProductData)
                
            }else{
                singletonObj.ProductItemCartLists.append(listOfCartProduct)
            }
            
            
            
        }
        
        
        
        
        productItemsCollectionView.reloadData()
        
        
        
    }
    
    func find(objecToFind: String?) -> Int? {
        for i in 0 ..< singletonObj.ProductItemCartLists.count {
          
            if singletonObj.ProductItemCartLists[i].ItemProductId == objecToFind {
                return i
            }
        }
        return nil
    }
}


extension Array where Array.Element: AnyObject {
    
    func index(ofElement element: Element) -> Int? {
        for (currentIndex, currentElement) in self.enumerated() {
            if currentElement === element {
                return currentIndex
            }
        }
        return nil
    }
}


