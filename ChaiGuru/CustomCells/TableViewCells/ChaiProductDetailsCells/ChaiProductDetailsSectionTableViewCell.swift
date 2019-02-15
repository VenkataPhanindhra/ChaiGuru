//
//  ChaiProductDetailsSectionTableViewCell.swift
//  ChaiGuru
//
//  Created by phanindhra on 2/14/19.
//  Copyright © 2019 phanindhra. All rights reserved.
//

import UIKit

class ChaiProductDetailsSectionTableViewCell: UITableViewCell {

    @IBOutlet weak var lblOfProdDescTitles : UILabel!
    @IBOutlet weak var imgOfProductOpen : UIImageView!
    
    @IBOutlet weak var lblOfBottomLine : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
