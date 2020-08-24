//
//  fourViewController.swift
//  photo
//
//  Created by hbe11678 on 2020/8/5.
//  Copyright © 2020 hbe11678. All rights reserved.
//

import UIKit

class fourViewController: UIViewController {

    
    @IBOutlet weak var place: UISegmentedControl!
    @IBOutlet weak var time: UISegmentedControl!
    @IBOutlet weak var money: UISegmentedControl!
    @IBOutlet weak var alley: UISegmentedControl!
    @IBOutlet weak var personily: UISegmentedControl!
    @IBOutlet weak var photo: UIImageView!

    @IBOutlet weak var btn: UIButton!
    let screenSize: CGRect = UIScreen.main.bounds
    
    @IBAction func send(_ sender: Any) {
        btn.isHidden = false
        if place.selectedSegmentIndex == 0 && time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 0 && alley.selectedSegmentIndex == 0 &&  personily.selectedSegmentIndex == 0{
            photo.image = UIImage(named: "cry")
        }else if place.selectedSegmentIndex == 0 && time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 0 && alley.selectedSegmentIndex == 0 &&  personily.selectedSegmentIndex == 1{
            photo.image = UIImage(named: "cry")
        }else if place.selectedSegmentIndex == 0 && time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 0 && alley.selectedSegmentIndex == 1 &&  personily.selectedSegmentIndex == 0{
            photo.image = UIImage(named: "cry")
        }else if place.selectedSegmentIndex == 0 && time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 0 && alley.selectedSegmentIndex == 1 &&  personily.selectedSegmentIndex == 1{
            photo.image = UIImage(named: "cry")
        }else if place.selectedSegmentIndex == 0 && time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 1 && alley.selectedSegmentIndex == 0 &&  personily.selectedSegmentIndex == 0{
            photo.image = UIImage(named: "貴賓狗")
        }else if place.selectedSegmentIndex == 0 && time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 1 && alley.selectedSegmentIndex == 0 &&  personily.selectedSegmentIndex == 1{
            photo.image = UIImage(named: "馬爾濟斯")
        }else if place.selectedSegmentIndex == 0 && time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 1 && alley.selectedSegmentIndex == 1 &&  personily.selectedSegmentIndex == 0{
            photo.image = UIImage(named: "雪納瑞")
        }else if place.selectedSegmentIndex == 0 && time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 1 && alley.selectedSegmentIndex == 1 &&  personily.selectedSegmentIndex == 1{
            photo.image = UIImage(named: "吉娃娃")
        }else if place.selectedSegmentIndex == 0 && time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 0 && alley.selectedSegmentIndex == 0 &&  personily.selectedSegmentIndex == 0{
            photo.image = UIImage(named: "cry")
        }else if place.selectedSegmentIndex == 0 && time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 0 && alley.selectedSegmentIndex == 0 &&  personily.selectedSegmentIndex == 1{
            photo.image = UIImage(named: "cry")
        }else if place.selectedSegmentIndex == 0 && time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 0 && alley.selectedSegmentIndex == 1 &&  personily.selectedSegmentIndex == 0{
            photo.image = UIImage(named: "cry")
        }else if place.selectedSegmentIndex == 0 && time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 0 && alley.selectedSegmentIndex == 1 &&  personily.selectedSegmentIndex == 1{
            photo.image = UIImage(named: "cry")
        }else if place.selectedSegmentIndex == 0 && time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 1 && alley.selectedSegmentIndex == 0 &&  personily.selectedSegmentIndex == 0{
            photo.image = UIImage(named: "貴賓狗")
        }else if place.selectedSegmentIndex == 0 && time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 1 && alley.selectedSegmentIndex == 0 &&  personily.selectedSegmentIndex == 1{
            photo.image = UIImage(named: "馬爾濟斯")
        }else if place.selectedSegmentIndex == 0 && time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 1 && alley.selectedSegmentIndex == 1 &&  personily.selectedSegmentIndex == 0{
            photo.image = UIImage(named: "雪納瑞")
        }else if place.selectedSegmentIndex == 0 && time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 1 && alley.selectedSegmentIndex == 1 &&  personily.selectedSegmentIndex == 1{
            photo.image = UIImage(named: "吉娃娃")
        }else if place.selectedSegmentIndex == 1 && time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 0 && alley.selectedSegmentIndex == 0 &&  personily.selectedSegmentIndex == 0{
            photo.image = UIImage(named: "cry")
        }else if place.selectedSegmentIndex == 1 && time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 0 && alley.selectedSegmentIndex == 0 &&  personily.selectedSegmentIndex == 1{
            photo.image = UIImage(named: "cry")
        }else if place.selectedSegmentIndex == 1 && time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 0 && alley.selectedSegmentIndex == 1 &&  personily.selectedSegmentIndex == 0{
            photo.image = UIImage(named: "cry")
        }else if place.selectedSegmentIndex == 1 && time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 0 && alley.selectedSegmentIndex == 1 &&  personily.selectedSegmentIndex == 1{
            photo.image = UIImage(named: "cry")
        }else if place.selectedSegmentIndex == 1 && time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 1 && alley.selectedSegmentIndex == 0 &&  personily.selectedSegmentIndex == 0{
            photo.image = UIImage(named: "貴賓狗")
        }else if place.selectedSegmentIndex == 1 && time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 1 && alley.selectedSegmentIndex == 0 &&  personily.selectedSegmentIndex == 1{
            photo.image = UIImage(named: "馬爾濟斯")
        }else if place.selectedSegmentIndex == 1 && time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 1 && alley.selectedSegmentIndex == 1 &&  personily.selectedSegmentIndex == 0{
            photo.image = UIImage(named: "雪納瑞")
        }else if place.selectedSegmentIndex == 1 && time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 1 && alley.selectedSegmentIndex == 1 &&  personily.selectedSegmentIndex == 1{
            photo.image = UIImage(named: "吉娃娃")
        }else if place.selectedSegmentIndex == 1 && time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 0 && alley.selectedSegmentIndex == 0 &&  personily.selectedSegmentIndex == 0{
            photo.image = UIImage(named: "cry")
        }else if place.selectedSegmentIndex == 1 && time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 0 && alley.selectedSegmentIndex == 0 &&  personily.selectedSegmentIndex == 1{
            photo.image = UIImage(named: "cry")
        }else if place.selectedSegmentIndex == 1 && time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 0 && alley.selectedSegmentIndex == 1 &&  personily.selectedSegmentIndex == 0{
            photo.image = UIImage(named: "cry")
        }else if place.selectedSegmentIndex == 1 && time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 0 && alley.selectedSegmentIndex == 1 &&  personily.selectedSegmentIndex == 1{
            photo.image = UIImage(named: "cry")
        }else if place.selectedSegmentIndex == 1 && time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 1 && alley.selectedSegmentIndex == 0 &&  personily.selectedSegmentIndex == 0{
            photo.image = UIImage(named: "黃金獵犬")
        }else if place.selectedSegmentIndex == 1 && time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 1 && alley.selectedSegmentIndex == 0 &&  personily.selectedSegmentIndex == 1{
            photo.image = UIImage(named: "柴犬")
        }else if place.selectedSegmentIndex == 1 && time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 1 && alley.selectedSegmentIndex == 1 &&  personily.selectedSegmentIndex == 0{
            photo.image = UIImage(named: "拉布拉多")
        }else if place.selectedSegmentIndex == 1 && time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 1 && alley.selectedSegmentIndex == 1 &&  personily.selectedSegmentIndex == 1{
            photo.image = UIImage(named: "德國牧羊犬")
        }
        

        
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
    override func viewDidLoad() {
    super.viewDidLoad()

   }
}
