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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
