//
//  LoginViewController.swift
//  ChaiGuru
//
//  Created by phanindhra on 2/6/19.
//  Copyright © 2019 phanindhra. All rights reserved.
//

import UIKit
import MaterialTextField


let MFDemoErrorDomain = "MFDemoErrorDomain"
let MFDemoErrorCode: Int = 100


class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var tfOfEmail : MFTextField!
    @IBOutlet weak var tfOfPassword : MFTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //for testing
        
        tfOfEmail.text = "nikhiltest@gmail.com"
        tfOfPassword.text = "test@123"
        

        UserDefaultStored.isLoggedIn = "0"
        
        tfOfEmail.delegate = self
        tfOfPassword.delegate = self
        
        self.tfOfEmail.placeholderAnimatesOnFocus = true
        self.tfOfPassword.placeholderAnimatesOnFocus = true
        
        self.tfOfEmail.tintColor = UIColor.mf_green()
        self.tfOfPassword.tintColor = UIColor.mf_green()
        
       // tfOfEmail.addTarget(self, action: #selector(validTxt(_:)), for: UIControl.Event.editingChanged)
        tfOfPassword.addTarget(self, action: #selector(validTxt(_:)), for: UIControl.Event.editingChanged)
        
        let taptGuesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        self.view.addGestureRecognizer(taptGuesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground), name:UIApplication.didEnterBackgroundNotification, object: nil)
        
    }
    
    @objc func hideKeyboard(_ sender: UITapGestureRecognizer) {
        self.allTextFieldResign()
    }
    @objc func didEnterBackground() {
        self.allTextFieldResign()
        self.view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //        animateViewMoving(up: false, moveValue: 100)
        //        self.view.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    func allTextFieldResign(){
        
        if tfOfPassword.isFirstResponder{
            tfOfPassword.resignFirstResponder()
        }else if tfOfEmail.isFirstResponder{
            tfOfEmail.resignFirstResponder()
        }
    }
    
    @objc func validTxt(_ text : UITextField){
        
        if text == tfOfEmail || text == tfOfPassword {
            self.validateTextField1(text: text)
        }
        
    }
    
    func error(withLocalizedDescription localizedDescription: String) -> Error? {
        let userInfo = [NSLocalizedDescriptionKey: localizedDescription]
        return NSError(domain: MFDemoErrorDomain as? String ?? "", code: Int(MFDemoErrorCode), userInfo: userInfo)
    }
    
    func validateTextField1(text : UITextField) {
        var error: Error? = nil
       
        if text == tfOfEmail{

            if !Utilities.sharedInstance.isValidEmail(testStr: tfOfEmail.text!){
                let errStr = NSLocalizedString("please enter Email Address...", comment: "")
                error = self.error(withLocalizedDescription: errStr)
            }

            tfOfEmail.setError(error, animated: true)

        }else{
        
            if !textField2IsValid() {
                let emailErr = NSLocalizedString("please enter correct password...", comment: "")
                error = self.error(withLocalizedDescription: emailErr)
            }
            tfOfPassword.setError(error, animated: true)
          
        }
    }
    
    func textField2IsValid() -> Bool {
        return (tfOfPassword.text?.count)! > 0
    }
    
    
    
    
    
    @IBAction func loginBtnCliked(_ sender : Any){
        
        //NEED TO WRITE API REQUEST
        
         var error: Error? = nil
        
        if tfOfEmail.text?.count == 0{
            
            let errStr = NSLocalizedString("please enter Email Address...", comment: "")
            error = self.error(withLocalizedDescription: errStr)
            tfOfEmail.setError(error, animated: true)
            
        }else if tfOfPassword.text?.count == 0{
            
            let errStr = NSLocalizedString("please enter correct password...", comment: "")
            error = self.error(withLocalizedDescription: errStr)
            tfOfPassword.setError(error, animated: true)
            
        }else{
            
            SignApiRequest()
            
        }
        
        
    }
    
    func SignApiRequest(){
        
        //Response success
//        {
//            "0": {
//                "user_id": "43",
//                "user_first_name": "Nihkil",
//                "user_last_name": "",
//                "user_email": "nikhiltest@gmail.com",
//                "user_cart": "0",
//                "user_status": "0",
//                "user_phone": "",
//                "user_password": "ceb6c970658f31504a901b89dcd3e461",
//                "user_address": "",
//                "user_pincode": "0",
//                "user_entry_time": "2019-02-04 14:05:02",
//                "user_gender": "",
//                "user_type": "user"
//            },
//            "msg": "Successfully Verified"
//        }
        
        
        //Failure response
//        {
//            "sql": "SELECT * FROM users WHERE (user_email = 'nikhiltest@gmail.com' OR user_phone = 'nikhiltest@gmail.com') AND user_password = '28b662d883b6d76fd96e4ddc5e9ba780' ",
//            "status": "Failed",
//            "msg": "Invalid Credentials"
//        }
        
        
        
        let postDict = ["email":tfOfEmail.text!,"password":tfOfPassword.text!]
        
        
        APIRequest.shareDInstance.callApiRequestResponse(methodName: ChaiguruConstants.APINames.user_login, postString: "", postInputStream: postDict as AnyObject, requestType: ChaiguruConstants.HTTP_Request_Post, SuccessResponse: { (dataResponse) in
            
            let dicOfResp = dataResponse as! NSDictionary
            
            if dicOfResp.chaiGuruObject(forKey: "status") == "Failed"{
                
                let messg = dicOfResp.chaiGuruObject(forKey: "msg")
                
               _ = SweetAlert().showAlert(messg)
                
            }else{
                
                let dictOfSucc = dicOfResp.object(forKey: "0") as! NSDictionary
                
                let name =  dictOfSucc.chaiGuruObject(forKey: "user_first_name")
                let email = dictOfSucc.chaiGuruObject(forKey: "user_email")
                
                UserDefaultStored.Email = email
                UserDefaultStored.Name = name
               
                DispatchQueue.main.async {
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    
                    let Tabbar = self.storyboard?.instantiateViewController(withIdentifier: "ChaiGuruTabBarViewController") as! ChaiGuruTabBarViewController
                    
                    let navigationContr = UINavigationController.init(rootViewController: Tabbar)
                    
                    navigationContr.isNavigationBarHidden = true
                    
                    Tabbar.selectedIndex = 0
                    
                    UserDefaultStored.isLoggedIn = "1"
                    
                    appDelegate.window?.rootViewController = navigationContr
                }
                
                
                
            }
           
            
            
            
            
        }) { (statusCode) in
            
            print(statusCode)
          
            _ = SweetAlert().showAlert("Something went wrong")
            
        }
        
    }
    
    
    
    
    
    @IBAction func forgotBtnCliked(_ sender : Any){
        
        
        
    }
    
    
    @IBAction func registrationBtnClicked(_ sender : Any){
        
        let registration = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        
        self.navigationController?.pushViewController(registration, animated: true)
    }
    
    
    //MARK:- TEXTFIELD DELEGATES
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       
        if textField == tfOfEmail{
           
            var error: Error? = nil
            if !Utilities.sharedInstance.isValidEmail(testStr: tfOfEmail.text!){
                let errStr = NSLocalizedString("please enter correct email address...", comment: "")
                error = self.error(withLocalizedDescription: errStr)
            }
            
            tfOfEmail.setError(error, animated: true)
            
        }
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    
        if textField == tfOfEmail{
            
            let error: Error? = nil
            tfOfEmail.setError(error, animated: true)
            
        }
        
        
        
    }
    
    
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//
//        if textField == tfOfEmail{
//
//            var error: Error? = nil
//            if !Utilities.sharedInstance.isValidEmail(testStr: tfOfEmail.text!){
//                let errStr = NSLocalizedString("please enter correct email address...", comment: "")
//                error = self.error(withLocalizedDescription: errStr)
//            }
//
//            tfOfEmail.setError(error, animated: true)
//
//        }
//
//        return true
//    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
