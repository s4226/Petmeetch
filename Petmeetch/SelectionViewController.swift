//
//  SelectionViewController.swift
//  Petmeetch
//
//  Created by Peiru Chiu on 2020/8/12.
//  Copyright © 2020 Peiru Chiu. All rights reserved.
//

import UIKit

class SelectionViewController: UIViewController {
    
    @IBOutlet weak var mainscreenImage: UIImageView!
    @IBAction func matchTapped(_sender: Any){
        self.performSegue(withIdentifier: "match", sender: self)

    }
    

    @IBAction func AdoptionTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "AR", sender: self)
        
    }
    @IBAction func ARTapped(_ sender: Any){
        self.performSegue(withIdentifier: "Adoption", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage()
        
        self.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
        self.navigationController?.navigationBar.shadowImage = image

        // Do any additional setup after loading the view.
    }
    @IBAction func UnWind(for segue:UIStoryboardSegue)
    {
        
        print("unwind...")
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
