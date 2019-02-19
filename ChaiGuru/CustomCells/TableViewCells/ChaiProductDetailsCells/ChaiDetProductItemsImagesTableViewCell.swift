//
//  ChaiDetProductItemsImagesTableViewCell.swift
//  ChaiGuru
//
//  Created by phanindhra on 2/14/19.
//  Copyright © 2019 phanindhra. All rights reserved.
//

import UIKit

class ChaiDetProductItemsImagesTableViewCell: UITableViewCell {

    @IBOutlet weak var imgOfCollectionViews : UICollectionView!
    @IBOutlet weak var pageControl : UIPageControl!
    
    @IBOutlet weak var lblOfProductName : UILabel!
    @IBOutlet weak var lblOfProductCost : UILabel!
    
    @IBOutlet weak var btnOfFavorite : UIButton!
    
    
    var arrOfAllImages = NSMutableArray()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func getAllProductImages(arrOfImages : [String]){
        
        
        
        
        arrOfAllImages.removeAllObjects()
        
        arrOfAllImages.addObjects(from: arrOfImages as [String])
        
        pageControl.numberOfPages = arrOfImages.count
        
        imgOfCollectionViews.reloadData()
        
        
    }
    
    

}

extension ChaiDetProductItemsImagesTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrOfAllImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChaiDetaSlideImagesCollectionViewCell", for: indexPath) as! ChaiDetaSlideImagesCollectionViewCell
        
      
        DispatchQueue.main.async {
            
            let image = "http://3.1.5.235/assets/templateassets/images/chaiguru/boxes/"
            
            let constructedImage = self.arrOfAllImages[indexPath.row] as! String
            
            let finaleImage = image + constructedImage
            
            let url = URL.init(string: finaleImage)
            
            cell.imgOfCollectionData.sd_setImage(with: url, completed: nil)
            
            
        }
        
        
        
  
        
        return cell
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        
        for case let SelectedCell as ChaiDetaSlideImagesCollectionViewCell in imgOfCollectionViews.visibleCells{
            
            let indexpath = imgOfCollectionViews.indexPath(for: SelectedCell)
            
            pageControl.currentPage = (indexpath?.row)!
            
        }
        
        
        
    }
    
    
    
}
