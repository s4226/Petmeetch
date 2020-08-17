//
//  AnimalDetailViewController.swift
//  Petmeetch
//
//  Created by Peiru Chiu on 2020/8/12.
//  Copyright © 2020 Peiru Chiu. All rights reserved.
//

import UIKit
import Kingfisher
import MapKit
import SafariServices
class AnimalDetailViewController: UIViewController{
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var AnimalImage: UIImageView!
    var animalData = Animal(animal_id: 0, animal_subid: "", animal_area_pkid: 0, animal_shelter_pkid: 0, animal_place: "", animal_kind: "", animal_sex: "", animal_bodytype: "", animal_colour: "", animal_age: "", animal_sterilization: "", animal_bacterin: "", animal_foundplace: "", animal_title: "", animal_status: "", animal_remark: "", animal_caption: "", animal_opendate: "", animal_closeddate: "", animal_update: "", animal_createtime: "", shelter_name: "", album_file: "", album_update: "", cDate: "", shelter_address: "", shelter_tel: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Configure the table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        
        let imageUrl = URL(string: animalData.album_file)
        let processor = DownsamplingImageProcessor(size: AnimalImage.bounds.size)
            |> RoundCornerImageProcessor(cornerRadius: 0)
                AnimalImage.kf.indicatorType = .activity
                    AnimalImage.kf.setImage(
            with: imageUrl,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
                print(value.image.size)

            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
       
    }
}
// MARK: - 按鈕點擊事件
extension AnimalDetailViewController{
    
    @IBAction func phoneButtonPress(_ sender: Any) {

        //打電話
        let phoneNumber = animalData.shelter_tel
            if let url = URL(string: "tel:\(phoneNumber)"){
                if UIApplication.shared.canOpenURL(url){
                    UIApplication.shared.open(url,options: [:],completionHandler: nil)
                }else{
                            print("無法開啟ＵＲＬ")
                        }
                    }else{
                        print("連結錯誤")
                    }
    }

    
}
// MARK: - tableview
extension AnimalDetailViewController: UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TelTableViewCell.self), for: indexPath) as! TelTableViewCell
            cell.phoneNumber = animalData.shelter_tel
            cell.selectionStyle = .none
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AddresTableViewCell.self), for: indexPath) as! AddresTableViewCell
            cell.Address.text = "所在地\n" + animalData.shelter_name
            cell.selectionStyle = .none
            return cell
       case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing:AnimalDetailTableViewCell.self), for: indexPath) as! AnimalDetailTableViewCell
            cell.kind.text = animalData.animal_kind
            cell.sex.text = sex[String(animalData.animal_sex)]!
            cell.bodytype.text =   bodytype[String(animalData.animal_bodytype)]!
            cell.color.text = animalData.animal_colour
            cell.age.text =   age[String(animalData.animal_age)]
            cell.sterilization.text = sterilization[String(animalData.animal_sterilization)]
            cell.selectionStyle = .none
            return cell
       case 3:
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing:RemarkTableViewCell.self), for: indexPath) as!RemarkTableViewCell
        if  animalData.animal_remark == ""{
            cell.remark.text = "備註\n無"
        }else{
            cell.remark.text = "備註\n" + animalData.animal_remark
        }
        cell.selectionStyle = .none
        return cell
       case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing:OtherTableViewCell.self), for: indexPath) as! OtherTableViewCell
            cell.createtime.text = "資料建立時間: " + animalData.animal_createtime
            cell.cDate.text = "資料更新時間: "+animalData.cDate
            cell.opendate.text = "開放認養時間: " + animalData.animal_opendate
            cell.id.text = "流水編號: " + String(animalData.animal_id)
            cell.subid.text = "區域編號: " + animalData.animal_subid
            cell.selectionStyle = .none
            return cell
      default:
            fatalError("Failed to instantiate the table view cell for detail view controller")
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(animalData.shelter_address) { (placemarks, error) in
                if let error = error {
            print(error.localizedDescription)
                    return
                }
                    if let location = placemarks?.first?.location {
                        let query = "?q=\(location.coordinate.latitude),\(location.coordinate.longitude)"
                        let urlString = "http://maps.apple.com/".appending(query)
                        if let url = URL(string: urlString){
                            let safariController = SFSafariViewController(url: url)
                            self.present(safariController, animated: true, completion: nil)
                        }

                    }
                    
                }
            
        case 1:
            break
        case 2:
            break
        case 3:
            break
        default:
            break
        }
        
            
        }

    
}
