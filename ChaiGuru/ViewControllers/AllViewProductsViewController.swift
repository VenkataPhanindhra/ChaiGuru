//
//  AllViewProductsViewController.swift
//  ChaiGuru
//
//  Created by phanindhra on 2/7/19.
//  Copyright © 2019 phanindhra. All rights reserved.
//

import UIKit

class AllViewProductsViewController: UIViewController {

    @IBOutlet weak var allProductsCollectionview : UICollectionView!
    @IBOutlet weak var lblOfproductTeaName : UILabel!
    
    
    var arrOfAllProducts : NSMutableArray!
    var strOfProductName : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        lblOfproductTeaName.text = strOfProductName
        
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func backBtnCLicked(_ sender :  Any){
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AllViewProductsViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrOfAllProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypesOfProductCollectionViewCell", for: indexPath) as! TypesOfProductCollectionViewCell
        
        let dictProductData = arrOfAllProducts[indexPath.row] as! NSDictionary
        
        collectionCell.lblOfProductName.text = dictProductData.chaiGuruObject(forKey: "p_name")
        collectionCell.lblOfProductCost.text = "₹" + dictProductData.chaiGuruObject(forKey: "p_price")
        
        collectionCell.imgOfCollections.layer.cornerRadius = 8
        collectionCell.imgOfCollections.layer.masksToBounds = true
        
        
        DispatchQueue.main.async {
            
            let img = dictProductData.chaiGuruObject(forKey: "img6")
            let constructOfImage = "http://3.1.5.235/assets/templateassets/images/chaiguru/home/"
            
            let finalImage = constructOfImage + img
            
            collectionCell.imgOfCollections.sd_setImage(with: URL.init(string: finalImage), placeholderImage: UIImage.init(named: "LoginLogo"))
            
        }
        
        
        
        
        return collectionCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width/2 - 10,height : 190)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let dictObj = arrOfAllProducts[indexPath.row] as! NSDictionary
        
        SingletonClass.sharedInstance.chaiGuruDetailsDict = dictObj
        
        let navigateProdDetail = self.storyboard?.instantiateViewController(withIdentifier: "ChaiGuruDetailsViewController") as! ChaiGuruDetailsViewController
        
        self.navigationController?.pushViewController(navigateProdDetail, animated: true)
    
    }
    
}
