//
//  fourViewController.swift
//  photo
//
//  Created by hbe11678 on 2020/8/5.
//  Copyright © 2020 hbe11678. All rights reserved.
//

import UIKit

class DogViewController: UIViewController {

    
    @IBOutlet weak var place: UISegmentedControl!
    @IBOutlet weak var time: UISegmentedControl!
    @IBOutlet weak var money: UISegmentedControl!
    @IBOutlet weak var alley: UISegmentedControl!
    @IBOutlet weak var personily: UISegmentedControl!
    @IBOutlet weak var photo: UIImageView!

    @IBOutlet weak var petlabel: UILabel!
    @IBOutlet weak var btn: UIButton!
    let screenSize: CGRect = UIScreen.main.bounds
    
    @IBAction func send(_ sender: Any) {
        btn.isHidden = false
        petlabel.isHidden = false
        if place.selectedSegmentIndex == 0 && time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 0 && alley.selectedSegmentIndex == 0 &&  personily.selectedSegmentIndex == 0{
            photo.image = UIImage(named: "cry")
            petlabel.text = "你目前不適合養寵物"
        }else if place.selectedSegmentIndex == 0 && time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 0 && alley.selectedSegmentIndex == 0 &&  personily.selectedSegmentIndex == 1{
            photo.image = UIImage(named: "cry")
            petlabel.text = "你目前不適合養寵物"
        }else if place.selectedSegmentIndex == 0 && time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 0 && alley.selectedSegmentIndex == 1 &&  personily.selectedSegmentIndex == 0{
            photo.image = UIImage(named: "cry")
            petlabel.text = "你目前不適合養寵物"
        }else if place.selectedSegmentIndex == 0 && time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 0 && alley.selectedSegmentIndex == 1 &&  personily.selectedSegmentIndex == 1{
            photo.image = UIImage(named: "cry")
            petlabel.text = "你目前不適合養寵物"
        }else if place.selectedSegmentIndex == 0 && time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 1 && alley.selectedSegmentIndex == 0 &&  personily.selectedSegmentIndex == 0{
            photo.image = UIImage(named: "西施犬")
            petlabel.text = "你適合養西施犬"
        }else if place.selectedSegmentIndex == 0 && time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 1 && alley.selectedSegmentIndex == 0 &&  personily.selectedSegmentIndex == 1{
            photo.image = UIImage(named: "馬爾濟斯")
            petlabel.text = "你適合養馬爾濟斯"
        }else if place.selectedSegmentIndex == 0 && time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 1 && alley.selectedSegmentIndex == 1 &&  personily.selectedSegmentIndex == 0{
            photo.image = UIImage(named: "雪納瑞")
            petlabel.text = "你適合養雪納瑞"
        }else if place.selectedSegmentIndex == 0 && time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 1 && alley.selectedSegmentIndex == 1 &&  personily.selectedSegmentIndex == 1{
            photo.image = UIImage(named: "吉娃娃")
            petlabel.text = "你適合養吉娃娃"
        }else if place.selectedSegmentIndex == 0 && time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 0 && alley.selectedSegmentIndex == 0 &&  personily.selectedSegmentIndex == 0{
            photo.image = UIImage(named: "cry")
            petlabel.text = "你目前不適合養寵物"
        }else if place.selectedSegmentIndex == 0 && time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 0 && alley.selectedSegmentIndex == 0 &&  personily.selectedSegmentIndex == 1{
            photo.image = UIImage(named: "cry")
            petlabel.text = "你目前不適合養寵物"
        }else if place.selectedSegmentIndex == 0 && time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 0 && alley.selectedSegmentIndex == 1 &&  personily.selectedSegmentIndex == 0{
            photo.image = UIImage(named: "cry")
            petlabel.text = "你目前不適合養寵物"
        }else if place.selectedSegmentIndex == 0 && time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 0 && alley.selectedSegmentIndex == 1 &&  personily.selectedSegmentIndex == 1{
            photo.image = UIImage(named: "cry")
            petlabel.text = "你目前不適合養寵物"
        }else if place.selectedSegmentIndex == 0 && time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 1 && alley.selectedSegmentIndex == 0 &&  personily.selectedSegmentIndex == 0{
            photo.image = UIImage(named: "西施犬")
            petlabel.text = "你適合養西施犬"
        }else if place.selectedSegmentIndex == 0 && time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 1 && alley.selectedSegmentIndex == 0 &&  personily.selectedSegmentIndex == 1{
            photo.image = UIImage(named: "馬爾濟斯")
            petlabel.text = "你適合養馬爾濟斯"
        }else if place.selectedSegmentIndex == 0 && time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 1 && alley.selectedSegmentIndex == 1 &&  personily.selectedSegmentIndex == 0{
            photo.image = UIImage(named: "雪納瑞")
            petlabel.text = "你適合養雪納瑞"
        }else if place.selectedSegmentIndex == 0 && time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 1 && alley.selectedSegmentIndex == 1 &&  personily.selectedSegmentIndex == 1{
            photo.image = UIImage(named: "吉娃娃")
            petlabel.text = "你適合養吉娃娃"
        }else if place.selectedSegmentIndex == 1 && time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 0 && alley.selectedSegmentIndex == 0 &&  personily.selectedSegmentIndex == 0{
            photo.image = UIImage(named: "cry")
            petlabel.text = "你目前不適合養寵物"
        }else if place.selectedSegmentIndex == 1 && time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 0 && alley.selectedSegmentIndex == 0 &&  personily.selectedSegmentIndex == 1{
            photo.image = UIImage(named: "cry")
            petlabel.text = "你目前不適合養寵物"
        }else if place.selectedSegmentIndex == 1 && time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 0 && alley.selectedSegmentIndex == 1 &&  personily.selectedSegmentIndex == 0{
            photo.image = UIImage(named: "cry")
            petlabel.text = "你目前不適合養寵物"
        }else if place.selectedSegmentIndex == 1 && time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 0 && alley.selectedSegmentIndex == 1 &&  personily.selectedSegmentIndex == 1{
            photo.image = UIImage(named: "cry")
            petlabel.text = "你目前不適合養寵物"
        }else if place.selectedSegmentIndex == 1 && time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 1 && alley.selectedSegmentIndex == 0 &&  personily.selectedSegmentIndex == 0{
            photo.image = UIImage(named: "西施犬")
            petlabel.text = "你適合養西施犬"
        }else if place.selectedSegmentIndex == 1 && time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 1 && alley.selectedSegmentIndex == 0 &&  personily.selectedSegmentIndex == 1{
            photo.image = UIImage(named: "馬爾濟斯")
            petlabel.text = "你適合養馬爾濟斯"
        }else if place.selectedSegmentIndex == 1 && time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 1 && alley.selectedSegmentIndex == 1 &&  personily.selectedSegmentIndex == 0{
            photo.image = UIImage(named: "雪納瑞")
            petlabel.text = "你適合養雪納瑞"
        }else if place.selectedSegmentIndex == 1 && time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 1 && alley.selectedSegmentIndex == 1 &&  personily.selectedSegmentIndex == 1{
            photo.image = UIImage(named: "吉娃娃")
            petlabel.text = "你適合養吉娃娃"
        }else if place.selectedSegmentIndex == 1 && time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 0 && alley.selectedSegmentIndex == 0 &&  personily.selectedSegmentIndex == 0{
            photo.image = UIImage(named: "cry")
            petlabel.text = "你目前不適合養寵物"
        }else if place.selectedSegmentIndex == 1 && time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 0 && alley.selectedSegmentIndex == 0 &&  personily.selectedSegmentIndex == 1{
            photo.image = UIImage(named: "cry")
            petlabel.text = "你目前不適合養寵物"
        }else if place.selectedSegmentIndex == 1 && time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 0 && alley.selectedSegmentIndex == 1 &&  personily.selectedSegmentIndex == 0{
            photo.image = UIImage(named: "cry")
            petlabel.text = "你目前不適合養寵物"
        }else if place.selectedSegmentIndex == 1 && time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 0 && alley.selectedSegmentIndex == 1 &&  personily.selectedSegmentIndex == 1{
            photo.image = UIImage(named: "cry")
            petlabel.text = "你目前不適合養寵物"
        }else if place.selectedSegmentIndex == 1 && time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 1 && alley.selectedSegmentIndex == 0 &&  personily.selectedSegmentIndex == 0{
            photo.image = UIImage(named: "黃金獵犬")
            petlabel.text = "你適合養黃金獵犬"
        }else if place.selectedSegmentIndex == 1 && time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 1 && alley.selectedSegmentIndex == 0 &&  personily.selectedSegmentIndex == 1{
            photo.image = UIImage(named: "柴犬")
            petlabel.text = "你適合養柴犬"
        }else if place.selectedSegmentIndex == 1 && time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 1 && alley.selectedSegmentIndex == 1 &&  personily.selectedSegmentIndex == 0{
            photo.image = UIImage(named: "拉布拉多")
            petlabel.text = "你適合養拉布拉多"
        }else if place.selectedSegmentIndex == 1 && time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 1 && alley.selectedSegmentIndex == 1 &&  personily.selectedSegmentIndex == 1{
            photo.image = UIImage(named: "德國牧羊犬")
            petlabel.text = "你適合養德國牧羊犬"
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
