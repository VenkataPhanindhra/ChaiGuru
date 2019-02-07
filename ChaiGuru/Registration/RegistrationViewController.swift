//
//  RegistrationViewController.swift
//  ChaiGuru
//
//  Created by phanindhra on 2/6/19.
//  Copyright © 2019 phanindhra. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var tfOfName : UITextField!
    @IBOutlet weak var tfOfEmail : UITextField!
    @IBOutlet weak var tfOfPassword : UITextField!
    
    @IBOutlet weak var termsandConditionsBtn : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func termsandConditionsBtnClicked(_ sender :  Any){
        
        
        
    }
    
    
    @IBAction func registrationBtnClicked(_ sender : Any){
        
        //NEED TO WRITE API REQUEST
        
//        let Tabbar = self.storyboard?.instantiateViewController(withIdentifier: "ChaiGuruTabBarViewController") as! ChaiGuruTabBarViewController
//
//        Tabbar.selectedIndex = 0
//
//        UserDefaultStored.isLoggedIn = "1"
//
//        self.navigationController?.pushViewController(Tabbar, animated: true)
        
        //3.1.5.235/api/api_v1.0.php/user_registration
        
//        //{"first_name":"Nihkil",
//        "last_name":"",
//        "email":"nikhiltest@gmail.com",
//        "password":"test@123"}
        
        let dict = ["first_name" : "12345","last_name":"","email":"12345@gmail.com","password":"test@123"]
        
        
        
        APIRequest.shareDInstance.callApiRequestResponse(methodName: ChaiguruConstants.APINames.user_registration, postString: "", postInputStream: dict as AnyObject, requestType: ChaiguruConstants.HTTP_Request_Post, SuccessResponse: { (dataResponse) in
            
            print(dataResponse)
            
            
        }) { (statusCode) in
            
            print(statusCode)
            
        }
        
        
        
    }
    
    @IBAction func signBtnClicked(_ sender : Any){
        
        let login = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        self.navigationController?.pushViewController(login, animated: true)
        
        
        
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
