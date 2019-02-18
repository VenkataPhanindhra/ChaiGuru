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
    @IBOutlet weak var viewOfBackgroundColor : UIView!
    
    var indexPathSection : Int! = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func backBtnClicked(_ sender : Any){
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        
        let label:UILabel = UILabel(frame: CGRect(x:0, y:0, width:width, height:CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }

}

extension ChaiGuruDetailsViewController : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1 || section == 2 || section == 3{
            return 0
        }else{
            
            if indexPathSection == section{
                return 1
            }else{
                return 0
            }
            
//            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 4 || indexPath.section == 5 || indexPath.section == 6{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChaiProductDetailsRowTableViewCell", for: indexPath) as! ChaiProductDetailsRowTableViewCell
            
           
            if indexPath.section == 4{
                cell.lblOfProductDetailExplanaton.text = SingletonClass.sharedInstance.chaiGuruDetailsDict.chaiGuruObject(forKey: "p_usage")
            }else if indexPath.section == 5{
                cell.lblOfProductDetailExplanaton.text = SingletonClass.sharedInstance.chaiGuruDetailsDict.chaiGuruObject(forKey: "p_benefits")
            }else if indexPath.section == 6{
                cell.lblOfProductDetailExplanaton.text = "Reviewssssssss Data to Show"
            }
            
            
            return cell
        }
        
       return UITableViewCell()
     }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0{
            
            let headerView = tableView.dequeueReusableCell(withIdentifier: "ChaiDetProductItemsImagesTableViewCell") as! ChaiDetProductItemsImagesTableViewCell
            
            headerView.lblOfProductName.text = SingletonClass.sharedInstance.chaiGuruDetailsDict.chaiGuruObject(forKey: "p_name")
            headerView.lblOfProductCost.text = "₹ " + SingletonClass.sharedInstance.chaiGuruDetailsDict.chaiGuruObject(forKey: "p_price")
            
            var arrOfImage = [String]()
            
            let img = SingletonClass.sharedInstance.chaiGuruDetailsDict.chaiGuruObject(forKey: "img")
            let img2 = SingletonClass.sharedInstance.chaiGuruDetailsDict.chaiGuruObject(forKey: "img2")
            let img3 = SingletonClass.sharedInstance.chaiGuruDetailsDict.chaiGuruObject(forKey: "img3")
            let img4 = SingletonClass.sharedInstance.chaiGuruDetailsDict.chaiGuruObject(forKey: "img4")
            let img5 = SingletonClass.sharedInstance.chaiGuruDetailsDict.chaiGuruObject(forKey: "img5")
            
            arrOfImage.append(img)
            arrOfImage.append(img2)
            arrOfImage.append(img3)
            arrOfImage.append(img4)
            arrOfImage.append(img5)
            
            headerView.getAllProductImages(arrOfImages: arrOfImage)
            
           
            return headerView
            
            
        }else if section == 1 || section == 2{
            
            let headerView = tableView.dequeueReusableCell(withIdentifier: "ChaiDetaDescrbtionsTableViewCell") as! ChaiDetaDescrbtionsTableViewCell
            
            if section == 1{
                
                headerView.lblOfProductDescr.text = "Description"
                
                headerView.lblOfExplana.text = SingletonClass.sharedInstance.chaiGuruDetailsDict.chaiGuruObject(forKey: "p_description")
                
                headerView.lblOfBottomLine.isHidden = true
                
            }else{
                
                headerView.lblOfProductDescr.text = "Ingredients:"
                
                headerView.lblOfExplana.text = SingletonClass.sharedInstance.chaiGuruDetailsDict.chaiGuruObject(forKey: "ingredients")
                
                headerView.lblOfBottomLine.isHidden = false
            }
            
            
            
            return headerView
            
        }else if section == 3{
            
            let headerView = tableView.dequeueReusableCell(withIdentifier: "ChaiDetaIngrediantsImagesTableViewCell") as! ChaiDetaIngrediantsImagesTableViewCell
            
            headerView.lblOfWaterQuantity.text = SingletonClass.sharedInstance.chaiGuruDetailsDict.chaiGuruObject(forKey: "p_weight")
            
            return headerView
            
        }else{
            
            let headerView = tableView.dequeueReusableCell(withIdentifier: "ChaiProductDetailsSectionTableViewCell") as! ChaiProductDetailsSectionTableViewCell
            
            if section == 4{
                headerView.lblOfProdDescTitles.text = "How to Use"
            }else if section == 5{
                headerView.lblOfProdDescTitles.text = "Benefits"
            }else if section == 6{
                headerView.lblOfProdDescTitles.text = "Reviews"
            }
            
            headerView.btnOfHeaderSection.tag = section
            
            headerView.btnOfHeaderSection.addTarget(self, action: #selector(headerViewClicked(_:)), for: .touchUpInside)
            
            if indexPathSection == section{
                
                headerView.imgOfProductOpen.image = UIImage.init(named: "DownArrowe")
                headerView.lblOfBottomLine.isHidden = true
                
            }else{
                headerView.imgOfProductOpen.image = UIImage.init(named: "UpArrow")
                headerView.lblOfBottomLine.isHidden = false
            }
            
            
            return headerView
            
        }
    }
    
    @objc func headerViewClicked(_ sender : UIButton){
        
        if indexPathSection == sender.tag {
            indexPathSection = 0
        }else{
           indexPathSection = sender.tag
        }
        
        
        
        
        tbOfProductDetails.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0{
            
            return 340
            
            
            
        }else if section == 1 || section == 2{
            
            if section == 1{
                
                let text  = SingletonClass.sharedInstance.chaiGuruDetailsDict.chaiGuruObject(forKey: "p_description")
                let font = UIFont(name: "Montserrat-Regular", size: 16.0)
                let width = self.view.frame.width - 32
                
                let height = heightForView(text: text, font: font!, width: width)
                
                return height + 85
                
            }else{
                
                let text  = SingletonClass.sharedInstance.chaiGuruDetailsDict.chaiGuruObject(forKey: "ingredients")
                let font = UIFont(name: "Montserrat-Regular", size: 16.0)
                let width = self.view.frame.width - 32
                
                let height = heightForView(text: text, font: font!, width: width)
                
                return height + 85
                
            }
            
            
          //  return UITableView.automaticDimension
        }else if section == 3{
            
            return 130
            
        }else{
           return 60
        }
        
        
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        
        if contentYoffset > 250{
            
            viewOfBackgroundColor.backgroundColor = .white
            
        }else{
            viewOfBackgroundColor.backgroundColor = .clear
        }
        
        
    }
    
    
    
}
