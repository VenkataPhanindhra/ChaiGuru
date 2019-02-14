//
//  HomeViewController.swift
//  ChaiGuru
//
//  Created by phanindhra on 2/7/19.
//  Copyright © 2019 phanindhra. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var slideCollectionView : UICollectionView!
    @IBOutlet weak var listOfTableView : UITableView!
    
    var arrayOfCategories : NSMutableArray!
    var arrayOfAllProducts : NSMutableArray!
    var arrayofDictProductObjects : NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        arrayOfCategories = NSMutableArray()
        arrayOfAllProducts = NSMutableArray()
        arrayofDictProductObjects = NSMutableArray()
        
        
        getCategoryTypes()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func getCategoryTypes(){
        
        APIRequest.shareDInstance.MBProgress(view: self.view, message: ChaiguruConstants.Loading)
        
        APIRequest.shareDInstance.callApiRequestResponse(methodName: ChaiguruConstants.APINames.GetCategories, postString: "", postInputStream: [:] as AnyObject, requestType: ChaiguruConstants.HTTP_Request_Post, SuccessResponse: { (dataResponse) in
            
//            DispatchQueue.main.async {
//                APIRequest.shareDInstance.hideProgreesHUD()
//            }
            
            self.arrayOfCategories.addObjects(from: dataResponse as! [Any])
            
            self.getAllProductData()
            
            
        }) { (statusCode) in
            DispatchQueue.main.async {
                APIRequest.shareDInstance.hideProgreesHUD()
            }
        }
        
        
    }
    
    
    func getAllProductData(){
        
       // APIRequest.shareDInstance.MBProgress(view: self.view, message: ChaiguruConstants.Loading)
        
        APIRequest.shareDInstance.callApiRequestResponse(methodName: ChaiguruConstants.APINames.get_products_data, postString: "", postInputStream: [:] as AnyObject, requestType: ChaiguruConstants.HTTP_Request_Post, SuccessResponse: { (dataResponse) in
            
            DispatchQueue.main.async {
                APIRequest.shareDInstance.hideProgreesHUD()
            }
        
            self.arrayOfAllProducts.addObjects(from: dataResponse as! [Any])
            
            self.devideDifferentCategoriesOfproductDataTypes()
            
        }) { (statusCode) in
            DispatchQueue.main.async {
                APIRequest.shareDInstance.hideProgreesHUD()
            }
        }
        
        
    }
    
    
    func devideDifferentCategoriesOfproductDataTypes(){
        
        
        for indexObj in 0..<arrayOfCategories.count{
            
            let arrOfObjects = NSMutableArray()
            let mutableDict  = NSMutableDictionary()
            
            let dictCategory = arrayOfCategories![indexObj] as! NSDictionary
            let categoryID = dictCategory.chaiGuruObject(forKey: "c_id")
            let categoryName = dictCategory.chaiGuruObject(forKey: "c_name")
            
            for indexObj in 0..<arrayOfAllProducts.count{
                
                let dictProduct = arrayOfAllProducts![indexObj] as! NSDictionary
                let productID = dictProduct.chaiGuruObject(forKey: "c_id")
                
                if categoryID == productID{
                   arrOfObjects.add(dictProduct)
                }
            }
            
            mutableDict.setValue(arrOfObjects, forKey: categoryName)
        
            arrayofDictProductObjects.add(mutableDict)
            
        }
        
      
        
        DispatchQueue.main.async {
            self.listOfTableView.reloadData()
        }
        
        
        
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


extension HomeViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomePageCollectionViewCell", for: indexPath) as! HomePageCollectionViewCell
        
        return collectionCell
    }
    
    
}

extension HomeViewController : UITableViewDelegate,UITableViewDataSource, NavigateToProductDetails{
    
    func showProductItemDetails() {
        
        let navigateProdDetail = self.storyboard?.instantiateViewController(withIdentifier: "ChaiGuruDetailsViewController") as! ChaiGuruDetailsViewController
        
        self.navigationController?.pushViewController(navigateProdDetail, animated: true)
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayofDictProductObjects.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        
        if indexPath.section == 0{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSlideScreensTableViewCell", for: indexPath) as! HomeSlideScreensTableViewCell
            
            cell.collectionOfSlidesView.reloadData()
            
            return cell
            
            
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypesOfProductItemsTableViewCell", for: indexPath) as! TypesOfProductItemsTableViewCell
            
            let indexSection = indexPath.section - 1
            
            let arrOfDict = arrayofDictProductObjects[indexSection] as! NSDictionary
            let dictCategory = arrayOfCategories![indexSection] as! NSDictionary
            let categoryName = dictCategory.chaiGuruObject(forKey: "c_name")
            
            
            let arrOfAllValues = arrOfDict.value(forKey: categoryName) as! NSMutableArray
            
            
            cell.getDataFromHomeScreen(arrayOfProducts: arrOfAllValues)
            
            cell.delegateObj = self
            
            return cell
            
        }
        
      }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0{
             return 220
            
        }else{
             return 200
        }
        
       
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
      
        if section == 0{
            
            return UIView()
            
        }else{
            
            let viewHeader = tableView.dequeueReusableCell(withIdentifier: "TypeOfProductNameTableViewCell") as! TypeOfProductNameTableViewCell
            
            viewHeader.btnOfViewAll.addTarget(self, action: #selector(viewAllBtnTapped(_:)), for: .touchUpInside)
            
            let indexSection = section - 1
            
            let dictCategory = arrayOfCategories![indexSection] as! NSDictionary
            let categoryName = dictCategory.chaiGuruObject(forKey: "c_name")
            
            viewHeader.lblOfProduct.text = categoryName
            
            return viewHeader
            
        }
        
       
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0{
            return 0
        }else{
            return 60
        }
        
        
    }
    
    @objc func viewAllBtnTapped(_ sender : Any){
        
        
        let viewAllVC = self.storyboard?.instantiateViewController(withIdentifier: "AllViewProductsViewController") as! AllViewProductsViewController
        
        
        self.navigationController?.pushViewController(viewAllVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tableview", indexPath)
    }
    
}
