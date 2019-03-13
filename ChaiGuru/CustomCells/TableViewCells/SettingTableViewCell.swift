//
//  SettingTableViewCell.swift
//  ChaiGuru
//
//  Created by phanindhra on 3/13/19.
//  Copyright © 2019 phanindhra. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    @IBOutlet weak var lblOfTitle : UILabel!
    @IBOutlet weak var lblOfLine : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
