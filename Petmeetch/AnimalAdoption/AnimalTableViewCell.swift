//
//  AnimalTableViewCell.swift
//  Petmeetch
//
//  Created by Peiru Chiu on 2020/8/12.
//  Copyright © 2020 Peiru Chiu. All rights reserved.
//

import UIKit
import DOFavoriteButtonNew
class AnimalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var favbutton: DOFavoriteButtonNew!

    @IBOutlet weak var city: UILabel!{
        didSet{
            city.layer.cornerRadius = 7
            city.clipsToBounds = true
            city.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            city.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            city.textAlignment = .center
        }

    }
    @IBOutlet weak var sex: UILabel!{
        didSet{
            sex.layer.cornerRadius = 7
            sex.clipsToBounds = true
            sex.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            sex.textColor = #colorLiteral(red: 0.2941176471, green: 0.3607843137, blue: 0.4784313725, alpha: 1)
            sex.textAlignment = .center
        }
        
    }
    @IBOutlet var animalimage: UIImageView!{
        didSet{
            animalimage.layer.cornerRadius = 7
            animalimage.clipsToBounds = true
        }
    }
    @IBOutlet weak var bodytype:UILabel!{
        didSet{
            bodytype.layer.cornerRadius = 7
            bodytype.clipsToBounds = true
            bodytype.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            bodytype.textColor = #colorLiteral(red: 0.2941176471, green: 0.3607843137, blue: 0.4784313725, alpha: 1)
            bodytype.textAlignment = .center
        }

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
