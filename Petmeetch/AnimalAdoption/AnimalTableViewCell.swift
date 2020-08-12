//
//  AnimalTableViewCell.swift
//  Petmeetch
//
//  Created by Peiru Chiu on 2020/8/12.
//  Copyright © 2020 Peiru Chiu. All rights reserved.
//

import UIKit

class AnimalTableViewCell: UITableViewCell {

    @IBOutlet weak var city: UILabel!{
        didSet{
            city.layer.cornerRadius = 7
            city.clipsToBounds = true
            city.backgroundColor = .systemBlue
            city.textColor = .white
            city.textAlignment = .center
        }

    }
    @IBOutlet weak var sex: UILabel!{
        didSet{
            sex.layer.cornerRadius = 7
            sex.clipsToBounds = true
            sex.backgroundColor = .systemBlue
            sex.textColor = .white
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
            bodytype.backgroundColor = .systemBlue
            bodytype.textColor = .white
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
