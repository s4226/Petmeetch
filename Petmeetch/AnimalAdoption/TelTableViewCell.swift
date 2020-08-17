//
//  TelTableViewCell.swift
//  Petmeetch
//
//  Created by Peiru Chiu on 2020/8/17.
//  Copyright © 2020 Peiru Chiu. All rights reserved.
//

import UIKit

class TelTableViewCell: UITableViewCell {
    var phoneNumber = ""
    @IBOutlet var tel: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
