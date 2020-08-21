//
//  FavoriteViewController.swift
//  AnimalAdoption
//
//  Created by Peiru Chiu on 2020/8/19.
//  Copyright © 2020 Peiru Chiu. All rights reserved.
//
import UIKit
import Kingfisher
import DropDown
import XLPagerTabStrip
class FavoriteViewController: UIViewController{
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var imageview: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "開發中..."
    }
}
extension FavoriteViewController: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "收藏")
    }

    
}
