//
//  BaseViewController.swift
//  AnimalAdoption
//
//  Created by Peiru Chiu on 2020/8/19.
//  Copyright © 2020 Peiru Chiu. All rights reserved.
//

import UIKit
import Kingfisher
import DropDown
import XLPagerTabStrip
import DOFavoriteButtonNew

class BaseViewController: ButtonBarPagerTabStripViewController{
    
    let graySpotifyColor = UIColor(red: 21/255.0, green: 21/255.0, blue: 24/255.0, alpha: 1.0)
    let darkGraySpotifyColor = UIColor(red: 19/255.0, green: 20/255.0, blue: 20/255.0, alpha: 1.0)

    var timer : Timer?
    override func viewDidLoad() {
        self.loadDesign()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timer =  Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { (timer) in
            self.navigationItem.title = "浪浪數量：\(UserDefaults.standard.integer(forKey: "animalResultscount"))"
        }
    }
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "One")
        let child_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "Two")
        navigationItem.title = child_1.navigationItem.title
        return [child_1,child_2]
    }
    func loadDesign(){
        // change selected bar color
        self.settings.style.selectedBarHeight = 1
        self.settings.style.selectedBarBackgroundColor = #colorLiteral(red: 1, green: 0.8026024103, blue: 0.7067040801, alpha: 1)
        self.settings.style.buttonBarBackgroundColor = #colorLiteral(red: 1, green: 0.8026024103, blue: 0.7067040801, alpha: 1)
        self.settings.style.buttonBarItemBackgroundColor = #colorLiteral(red: 1, green: 0.8026024103, blue: 0.7067040801, alpha: 1)
        self.settings.style.selectedBarBackgroundColor = .white
        self.settings.style.buttonBarItemFont = .systemFont(ofSize: 16)
        self.settings.style.selectedBarHeight = 2.0
        self.settings.style.buttonBarMinimumLineSpacing = 0
        self.settings.style.buttonBarItemTitleColor = UIColor.white
        self.settings.style.buttonBarItemsShouldFillAvailableWidth = true
        self.settings.style.buttonBarLeftContentInset = 0
        self.settings.style.buttonBarRightContentInset = 0

        // 切换Tab时操作
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }

            oldCell?.label.textColor = .orange
            newCell?.label.textColor = .orange

        }
    }
}
