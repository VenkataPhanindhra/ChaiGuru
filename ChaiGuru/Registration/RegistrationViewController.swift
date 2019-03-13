//
//  RegistrationViewController.swift
//  ChaiGuru
//
//  Created by phanindhra on 2/6/19.
//  Copyright © 2019 phanindhra. All rights reserved.
//

import UIKit
import MaterialTextField

class RegistrationViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var tfOfName : MFTextField!
    @IBOutlet weak var tfOfEmail : MFTextField!
    @IBOutlet weak var tfOfPassword : MFTextField!
    
    @IBOutlet weak var termsandConditionsBtn : UIButton!
    
    @IBOutlet weak var imgOfTerms : UIImageView!
    
    var termsAndConditions = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tfOfEmail.delegate = self
        tfOfPassword.delegate = self
        tfOfName.delegate = self
        
        self.tfOfEmail.placeholderAnimatesOnFocus = true
        self.tfOfPassword.placeholderAnimatesOnFocus = true
        self.tfOfName.placeholderAnimatesOnFocus = true
        
        self.tfOfEmail.tintColor = UIColor.mf_green()
        self.tfOfPassword.tintColor = UIColor.mf_green()
        self.tfOfName.tintColor = UIColor.mf_green()
        
        tfOfName.addTarget(self, action: #selector(validTxt(_:)), for: UIControl.Event.editingChanged)
        tfOfPassword.addTarget(self, action: #selector(validTxt(_:)), for: UIControl.Event.editingChanged)
        
        let taptGuesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        self.view.addGestureRecognizer(taptGuesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground), name:UIApplication.didEnterBackgroundNotification, object: nil)
        
        
        // Do any additional setup after loading the view.
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
        
        if text == tfOfName || text == tfOfPassword {
            self.validateTextField1(text: text)
        }
        
    }
    
    func error(withLocalizedDescription localizedDescription: String) -> Error? {
        let userInfo = [NSLocalizedDescriptionKey: localizedDescription]
        return NSError(domain: MFDemoErrorDomain as? String ?? "", code: Int(MFDemoErrorCode), userInfo: userInfo)
    }
    
    func validateTextField1(text : UITextField) {
        var error: Error? = nil
        
        if text == tfOfName{
            
            if !textField1IsValid() {
                let emailErr = NSLocalizedString("please enter name...", comment: "")
                error = self.error(withLocalizedDescription: emailErr)
            }
            tfOfName.setError(error, animated: true)
            
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
    func textField1IsValid() -> Bool {
        return (tfOfName.text?.count)! > 0
    }
    
    
    @IBAction func termsandConditionsBtnClicked(_ sender :  Any){
        
        if termsAndConditions == false{
            termsAndConditions = true
            
            imgOfTerms.image = UIImage.init(named: "termsgreen")
            
        }else{
            termsAndConditions = false
            
             imgOfTerms.image = UIImage.init(named: "Check_UnSele")
        }
        
        
        
    }
    
    
    
    @IBAction func registrationBtnClicked(_ sender : Any){
        
        //NEED TO WRITE API REQUEST
        

        var error: Error? = nil
        if tfOfName.text?.count == 0{
            
            let errStr = NSLocalizedString("please enter name...", comment: "")
            error = self.error(withLocalizedDescription: errStr)
            tfOfName.setError(error, animated: true)
            
        }
        else if tfOfEmail.text?.count == 0{
            
            let errStr = NSLocalizedString("please enter Email Address...", comment: "")
            error = self.error(withLocalizedDescription: errStr)
            tfOfEmail.setError(error, animated: true)
            
        }else if tfOfPassword.text?.count == 0{
            
            let errStr = NSLocalizedString("please enter correct password...", comment: "")
            error = self.error(withLocalizedDescription: errStr)
            tfOfPassword.setError(error, animated: true)
            
        }else if termsAndConditions == false{
            
            _ = SweetAlert().showAlert("please select terms and conditions")
            
        } else{
            
            DispatchQueue.main.async {
                self.registrationApiRequest()
            }
            
          }
        
        
        
    }
    
    func registrationApiRequest(){
        
        
        let dict = ["first_name" :tfOfName.text!,
                    "last_name":"",
                    "email":tfOfEmail.text!,
                    "password":tfOfPassword.text!]
        
        APIRequest.shareDInstance.MBProgress(view: self.view, message: "Loading...")
        
        APIRequest.shareDInstance.callApiRequestResponse(methodName: ChaiguruConstants.APINames.user_registration, postString: "", postInputStream: dict as AnyObject, requestType: ChaiguruConstants.HTTP_Request_Post, SuccessResponse: { (dataResponse) in
            
            DispatchQueue.main.async {
                APIRequest.shareDInstance.hideProgreesHUD()
            }
            
            
            let dicOfResp = dataResponse as! NSDictionary
            
            if dicOfResp.chaiGuruObject(forKey: "status") == "Failed"{
                
                let messg = dicOfResp.chaiGuruObject(forKey: "msg")
                
                _ = SweetAlert().showAlert(messg)
                
            }else{
                
                
                DispatchQueue.main.async {
                    
                    UserDefaultStored.Email = self.tfOfEmail.text!
                    UserDefaultStored.Name = self.tfOfName.text!
                    UserDefaultStored.Password = self.tfOfPassword.text!
                    
                    UserDefaultStored.userId = dicOfResp.chaiGuruObject(forKey: "user_id")
                    
                    
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
            DispatchQueue.main.async {
                APIRequest.shareDInstance.hideProgreesHUD()
            }
            
            
             _ = SweetAlert().showAlert("Something went wrong")
        }
        
        
        
    }
    
    
    
    @IBAction func signBtnClicked(_ sender : Any){
        
        let login = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        self.navigationController?.pushViewController(login, animated: true)
        
        
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
