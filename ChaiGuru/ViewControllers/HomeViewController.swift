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


extension HomeViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomePageCollectionViewCell", for: indexPath) as! HomePageCollectionViewCell
        
        return collectionCell
    }
    
    
}

extension HomeViewController : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TypesOfProductItemsTableViewCell", for: indexPath) as! TypesOfProductItemsTableViewCell
        
        cell.productItemsCollectionView.reloadData()
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        let viewHeader = tableView.dequeueReusableCell(withIdentifier: "TypeOfProductNameTableViewCell") as! TypeOfProductNameTableViewCell
        
        
        
        
        return viewHeader
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
}
