//
//  SettingViewController.swift
//  ChaiGuru
//
//  Created by phanindhra on 3/10/19.
//  Copyright © 2019 phanindhra. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var tbOfSetting : UITableView!
    @IBOutlet weak var imgOfProfilePic : UIImageView!
    @IBOutlet weak var lblOfName : UILabel!
    @IBOutlet weak var lblOfEmail : UILabel!
    
    var arrOfSettings = ["Order History","Manage Address","Payments","Help"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        
        
        imgOfProfilePic.layer.cornerRadius = imgOfProfilePic.frame.size.width/2 - 15
        
        lblOfName.text = UserDefaultStored.Name
        lblOfEmail.text = UserDefaultStored.Email
        
    }

    
    
    
    

}


extension SettingViewController : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return arrOfSettings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as! SettingTableViewCell
        
        cell.lblOfTitle.text = arrOfSettings[indexPath.row]
        
        if indexPath.row == arrOfSettings.count - 1{
            cell.lblOfLine.isHidden = true
        }else{
            cell.lblOfLine.isHidden = false
        }
        
        cell.selectionStyle = .none
        return cell
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 1{
            
            let manageAddress = self.storyboard?.instantiateViewController(withIdentifier: "ManageAddressViewController") as! ManageAddressViewController
            
            self.navigationController?.pushViewController(manageAddress, animated: true)
        }
        
    }
    
    
    
}
