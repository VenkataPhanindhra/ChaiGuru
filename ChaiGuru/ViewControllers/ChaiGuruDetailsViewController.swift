//
//  ChaiGuruDetailsViewController.swift
//  ChaiGuru
//
//  Created by phanindhra on 2/7/19.
//  Copyright © 2019 phanindhra. All rights reserved.
//

import UIKit

class ChaiGuruDetailsViewController: UIViewController {

    @IBOutlet weak var tbOfProductDetails : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

extension ChaiGuruDetailsViewController : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1 || section == 2 || section == 3{
            return 0
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 4 || indexPath.section == 5 || indexPath.section == 6{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChaiProductDetailsRowTableViewCell", for: indexPath) as! ChaiProductDetailsRowTableViewCell
            
            cell.lblOfProductDetailExplanaton.text = "explanation"
            
            return cell
        }
        
       return UITableViewCell()
     }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0{
            
            let headerView = tableView.dequeueReusableCell(withIdentifier: "ChaiDetProductItemsImagesTableViewCell") as! ChaiDetProductItemsImagesTableViewCell
            headerView.lblOfProductName.text = "ssd"
            headerView.lblOfProductCost.text = "121"
            
            headerView.imgOfCollectionViews.reloadData()
            return headerView
        }else if section == 1 || section == 2{
            
            let headerView = tableView.dequeueReusableCell(withIdentifier: "ChaiDetaDescrbtionsTableViewCell") as! ChaiDetaDescrbtionsTableViewCell
            headerView.lblOfProductDescr.text = "sdds"
            
            headerView.lblOfExplana.text = "hvsajhvasvffvghaghsagh"
            return headerView
            
        }else if section == 3{
            
            let headerView = tableView.dequeueReusableCell(withIdentifier: "ChaiDetaIngrediantsImagesTableViewCell") as! ChaiDetaIngrediantsImagesTableViewCell
            
            headerView.lblOfWaterQuantity.text = "200g"
            
            return headerView
            
        }else{
            
            let headerView = tableView.dequeueReusableCell(withIdentifier: "ChaiProductDetailsSectionTableViewCell") as! ChaiProductDetailsSectionTableViewCell
            
            headerView.lblOfProdDescTitles.text = "aaa"
            
            return headerView
            
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0{
            return 270
        }else if section == 1 || section == 2{
            return 100
        }else if section == 3{
            return 150
        }else{
           return 60
        }
        
        
    }
    
    
    
    
    
    
    
}
