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
import SnapKit

class BaseViewController: ButtonBarPagerTabStripViewController{
    
    @IBOutlet weak var baseview: UIView!
    
    var timer : Timer?
    override func viewDidLoad() {
        self.loadDesign()
        super.viewDidLoad()
        containerView.snp.makeConstraints{(make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(36)
        }
                
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
        self.settings.style.selectedBarBackgroundColor = #colorLiteral(red: 0.8737248778, green: 0.4631153941, blue: 0.4026138783, alpha: 1)
        self.settings.style.buttonBarBackgroundColor = #colorLiteral(red: 0.8737248778, green: 0.4631153941, blue: 0.4026138783, alpha: 1)
        self.settings.style.buttonBarItemBackgroundColor = #colorLiteral(red: 0.8737248778, green: 0.4631153941, blue: 0.4026138783, alpha: 1)
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

            oldCell?.label.textColor = .white
            newCell?.label.textColor = .white

        }
    }
}
