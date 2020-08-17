//
//  AnimalDetailTableViewCell.swift
//  Petmeetch
//
//  Created by Peiru Chiu on 2020/8/12.
//  Copyright © 2020 Peiru Chiu. All rights reserved.
//

import UIKit


class AnimalDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tagicon: UIImageView!


    @IBOutlet var kind: UILabel!{
        didSet{
            kind.layer.cornerRadius = 5
            kind.clipsToBounds = true
            kind.backgroundColor = #colorLiteral(red: 0.8392156863, green: 0.3333333333, blue: 0.3333333333, alpha: 1)
            kind.textColor = .white
            kind.textAlignment = .center
        }

    }
    
    @IBOutlet var sex: UILabel!{
        didSet{
            sex.layer.cornerRadius = 5
            sex.clipsToBounds = true
            sex.backgroundColor = #colorLiteral(red: 0.8392156863, green: 0.3333333333, blue: 0.3333333333, alpha: 1)
            sex.textColor = .white
            sex.textAlignment = .center
        }

    }
    
    @IBOutlet var bodytype: UILabel!{
        didSet{
            bodytype.layer.cornerRadius = 5
            bodytype.clipsToBounds = true
            bodytype.backgroundColor = #colorLiteral(red: 0.8392156863, green: 0.3333333333, blue: 0.3333333333, alpha: 1)
            bodytype.textColor = .white
            bodytype.textAlignment = .center
        }

    }
    
    @IBOutlet var color: UILabel!{
        didSet{
            color.layer.cornerRadius = 5
            color.clipsToBounds = true
            color.backgroundColor = #colorLiteral(red: 0.8392156863, green: 0.3333333333, blue: 0.3333333333, alpha: 1)
            color.textColor = .white
            color.textAlignment = .center
        }
    }
    
    @IBOutlet var age: UILabel!{
        didSet{
            age.layer.cornerRadius = 5
            age.clipsToBounds = true
            age.backgroundColor = #colorLiteral(red: 0.8392156863, green: 0.3333333333, blue: 0.3333333333, alpha: 1)
            age.textColor = .white
            age.textAlignment = .center
        }

        
    }
    
    @IBOutlet var sterilization: UILabel!
    {
        didSet{
            sterilization.layer.cornerRadius = 5
            sterilization.clipsToBounds = true
            sterilization.backgroundColor = #colorLiteral(red: 0.8392156863, green: 0.3333333333, blue: 0.3333333333, alpha: 1)
            sterilization.textColor = .white
            sterilization.textAlignment = .center
        }

    }
    @IBOutlet weak var mark: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
