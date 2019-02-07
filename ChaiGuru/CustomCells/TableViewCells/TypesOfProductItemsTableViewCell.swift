//
//  TypesOfProductItemsTableViewCell.swift
//  ChaiGuru
//
//  Created by phanindhra on 2/8/19.
//  Copyright © 2019 phanindhra. All rights reserved.
//

import UIKit

class TypesOfProductItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var productItemsCollectionView : UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


extension TypesOfProductItemsTableViewCell : UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypesOfProductCollectionViewCell", for: indexPath) as! TypesOfProductCollectionViewCell
        
        
        
        
        return collectionCell
    }
    
    
    
    
    
}
