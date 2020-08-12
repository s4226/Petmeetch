//
//  OtherTableViewCell.swift
//  Petmeetch
//
//  Created by Peiru Chiu on 2020/8/12.
//  Copyright © 2020 Peiru Chiu. All rights reserved.
//

import UIKit

class OtherTableViewCell: UITableViewCell {
    

    @IBOutlet var createtime: UILabel!
    
    @IBOutlet var cDate: UILabel!
    
    @IBOutlet var opendate: UILabel!
    
    @IBOutlet var id: UILabel!
    
    @IBOutlet var subid: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
