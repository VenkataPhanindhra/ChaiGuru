//
//  LoginViewController.swift
//  ChaiGuru
//
//  Created by phanindhra on 2/6/19.
//  Copyright © 2019 phanindhra. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var tfOfEmail : UITextField!
    @IBOutlet weak var tfOfPassword : UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func loginBtnCliked(_ sender : Any){
        
        //NEED TO WRITE API REQUEST
        
        let Tabbar = self.storyboard?.instantiateViewController(withIdentifier: "ChaiGuruTabBarViewController") as! ChaiGuruTabBarViewController
        
        Tabbar.selectedIndex = 0
        
        UserDefaultStored.isLoggedIn = "1"
        
        self.navigationController?.pushViewController(Tabbar, animated: true)
        
        
    }
    
    @IBAction func forgotBtnCliked(_ sender : Any){
        
        
        
    }
    
    
    @IBAction func registrationBtnClicked(_ sender : Any){
        
        let registration = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        
        self.navigationController?.pushViewController(registration, animated: true)
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
