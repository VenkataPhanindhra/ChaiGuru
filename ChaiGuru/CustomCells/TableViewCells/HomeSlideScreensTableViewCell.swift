//
//  HomeSlideScreensTableViewCell.swift
//  ChaiGuru
//
//  Created by phanindhra on 2/14/19.
//  Copyright © 2019 phanindhra. All rights reserved.
//

import UIKit

class HomeSlideScreensTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionOfSlidesView : UICollectionView!
    
    var arrOfGetImages = NSMutableArray()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func getImagesData(arrofImages : NSMutableArray){
        
        arrOfGetImages.removeAllObjects()
        
        arrOfGetImages.addObjects(from: arrofImages as! [Any])
        
        collectionOfSlidesView.reloadData()
    }
    

}

extension HomeSlideScreensTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomePageCollectionViewCell", for: indexPath) as! HomePageCollectionViewCell
        
        cell.imgOfCollections.layer.cornerRadius = 8
        cell.imgOfCollections.layer.masksToBounds = true
        
        let constructOfImage = "http://3.1.5.235/assets/templateassets/images/chaiguru/home/greenteacup1.jpg"
        
        
        
        cell.imgOfCollections.sd_setImage(with: URL.init(string: constructOfImage), placeholderImage: UIImage.init(named: "LoginLogo"))
        
//        if indexPath.row == 0{
//            cell.imgOfCollections.backgroundColor = UIColor.blue
//        }else if indexPath.row == 1{
//            cell.imgOfCollections.backgroundColor = UIColor.black
//        }else{
//            cell.imgOfCollections.backgroundColor = UIColor.orange
//        }
        
        
        return cell
    }
    
    
   
    
}
