//
//  OrderViewController.swift
//  ChaiGuru
//
//  Created by phanindhra on 3/18/19.
//  Copyright © 2019 phanindhra. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnClicked(_ sender : Any){
        
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
