//
//  threeViewController.swift
//  photo
//
//  Created by hbe11678 on 2020/8/7.
//  Copyright © 2020 hbe11678. All rights reserved.
//

import UIKit

class threeViewController: UIViewController {

    
    @IBOutlet weak var time: UISegmentedControl!
    
    @IBOutlet weak var money: UISegmentedControl!
    
    @IBOutlet weak var allergic: UISegmentedControl!
    
    @IBOutlet weak var personality: UISegmentedControl!
    
    
    @IBOutlet weak var photo: UIImageView!

    
    @IBOutlet weak var btn: UIButton!
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    @IBAction func send(_ sender: Any) {
        btn.isHidden = false
        if time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 0 && allergic.selectedSegmentIndex == 0 &&  personality.selectedSegmentIndex == 0{
                    photo.image = UIImage(named: "cry")
                }else if time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 0 && allergic.selectedSegmentIndex == 0 &&  personality.selectedSegmentIndex == 1{
                    photo.image = UIImage(named: "cry")
                }else if time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 0 && allergic.selectedSegmentIndex == 1 &&  personality.selectedSegmentIndex == 0{
                    photo.image = UIImage(named: "cry")
                }else if time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 0 && allergic.selectedSegmentIndex == 1 &&  personality.selectedSegmentIndex == 1{
                    photo.image = UIImage(named: "cry")
                }else if time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 1 && allergic.selectedSegmentIndex == 0 &&  personality.selectedSegmentIndex == 0{
                    photo.image = UIImage(named: "波斯貓")
                }else if time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 1 && allergic.selectedSegmentIndex == 0 &&  personality.selectedSegmentIndex == 1{
                    photo.image = UIImage(named: "布偶貓")
                }else if time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 1 && allergic.selectedSegmentIndex == 1 &&  personality.selectedSegmentIndex == 0{
                    photo.image = UIImage(named: "俄羅斯藍貓")
                }else if time.selectedSegmentIndex == 0 && money.selectedSegmentIndex == 1 && allergic.selectedSegmentIndex == 1 &&  personality.selectedSegmentIndex == 1{
                    photo.image = UIImage(named: "英國短毛貓")
                }else if time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 0 && allergic.selectedSegmentIndex == 0 &&  personality.selectedSegmentIndex == 0{
                    photo.image = UIImage(named: "cry")
                }else if time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 0 && allergic.selectedSegmentIndex == 0 &&  personality.selectedSegmentIndex == 1{
                    photo.image = UIImage(named: "cry")
                }else if time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 0 && allergic.selectedSegmentIndex == 1 &&  personality.selectedSegmentIndex == 0{
                    photo.image = UIImage(named: "cry")
                }else if time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 0 && allergic.selectedSegmentIndex == 1 &&  personality.selectedSegmentIndex == 1{
                    photo.image = UIImage(named: "cry")
                }else if time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 1 && allergic.selectedSegmentIndex == 0 &&  personality.selectedSegmentIndex == 0{
                    photo.image = UIImage(named: "西伯利亞貓")
                }else if time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 1 && allergic.selectedSegmentIndex == 0 &&  personality.selectedSegmentIndex == 1{
                    photo.image = UIImage(named: "緬因貓")
                }else if time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 1 && allergic.selectedSegmentIndex == 1 &&  personality.selectedSegmentIndex == 0{
                    photo.image = UIImage(named: "暹羅貓")
                }else if time.selectedSegmentIndex == 1 && money.selectedSegmentIndex == 1 && allergic.selectedSegmentIndex == 1 &&  personality.selectedSegmentIndex == 1{
                    photo.image = UIImage(named: "美國短毛貓")
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
    let borderAlpha : CGFloat = 0.7
    let cornerRadius : CGFloat = 5.0

   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}
