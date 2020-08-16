//
//  AnimalViewController.swift
//  Petmeetch
//
//  Created by Peiru Chiu on 2020/8/12.
//  Copyright © 2020 Peiru Chiu. All rights reserved.
//

import UIKit
import Kingfisher
import DropDown
let cityDict: [String : String] = ["2": "臺北市","3": "新北市", "4": "基隆市","5": "宜蘭縣","6": "桃園縣","7": "新竹縣","8": "新竹市", "9": "苗栗縣","10": "臺中市","11": "彰化縣","12": "南投縣","13": "雲林縣","14": "嘉義縣","15": "嘉義市", "16": "臺南市", "17": "高雄市","18": "屏東縣","19": "花蓮縣", "20" :"臺東縣","21": "澎湖縣","22": "金門縣","23": "連江縣"]
let pickercity: [String : Int] = ["臺北市":2,"新北市":3,"基隆市":4,"宜蘭縣":5,"桃園縣":6,"新竹縣":7,"新竹市":8, "苗栗縣":9,"臺中市": 10,"彰化縣":11,"南投縣":12,"雲林縣":13,"嘉義縣":14,"嘉義市":15,"臺南市":16, "高雄市":17,"屏東縣":18,"花蓮縣":19,"臺東縣": 20,"澎湖縣":21,"金門縣":22,"連江縣":23]
let ageDict:[String: String] = ["幼年":"CHILD","成年":"ADULT"]
let bodyTypeDict:[String: String] = ["小型": "SMALL","中型":"MEDIUM","大型":"BIG"]
let sexDict:[String: String] = ["公":"M","母":"F"]
let kindDict:[String: String] = ["貓":"貓","狗":"狗"]
let shelter: [String : String] = [ "48": "基隆市寵物銀行","49": "臺北市動物之家","50": "新北市板橋區公立動物之家","51": "新北市新店區公立動物之家","53": "新北市中和區公立動物之家","55": "新北市淡水區公立動物之家","56": "新北市瑞芳區公立動物之家","58": "新北市五股區公立動物之家","59": "新北市八里區公立動物之家","60": "新北市三芝區公立動物之家","61": "桃園市動物保護教育園區","62": "新竹市動物收容所","63": "新竹縣動物收容所","67": "臺中市動物之家南屯園區","68": "臺中市動物之家后里園區","69": "彰化縣流浪狗中途之家","70": "南投縣公立動物收容所","71": "嘉義市流浪犬收容中心","72": "嘉義縣流浪犬中途之家","73": "臺南市動物之家灣裡站","74": "臺南市動物之家善化站","75": "高雄市壽山動物保護教育園區","76": "高雄市燕巢動物保護關愛園區","77": "屏東縣流浪動物收容所","78": "宜蘭縣流浪動物中途之家","79":"花蓮縣流浪犬中途之家","80": "臺東縣動物收容中心","81": "連江縣流浪犬收容中心","82": "金門縣動物收容中心","83": "澎湖縣流浪動物收容中心","89":"雲林縣流浪動物收容所","92": "新北市政府動物保護防疫處","96": "苗栗縣生態保育教育中心"]
let sex: [String : String] = ["M": "公","F":"母","N":"未知"]
let bodytype:[String: String] = ["SMALL": "小型","MEDIUM":"中型","BIG":"大型"]
let age:[String: String] = ["CHILD":"幼年","ADULT":"成年"]
let sterilization:[String: String] = ["T":"已絕育","F":"未絕育","N":"未輸入"]
class AnimalViewController: UIViewController{
    //MARK: - Properties
    @IBOutlet weak var typeButton: UIButton!
    @IBOutlet weak var sexButton: UIButton!
    @IBOutlet weak var bodytypeButton: UIButton!
    @IBOutlet weak var ageButton: UIButton!
    @IBOutlet weak var cityButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    
    //MARK: - DropDown's
    let typeDropDown = DropDown()
    let sexDropDown = DropDown()
    let bodytypeDropDown = DropDown()
    let ageDropDown = DropDown()
    let cityDropDown = DropDown()
    
    lazy var dropDowns: [DropDown] = {
        return [
            self.typeDropDown,
            self.sexDropDown,
            self.bodytypeDropDown,
            self.ageDropDown,
            self.cityDropDown
        ]
    }()
    
//    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var tableView: UITableView!
    let kind = ["全部","狗","貓","其他"]
    let city = ["全部縣市","臺北市","新北市","基隆市","宜蘭縣","桃園縣","新竹縣","新竹市","苗栗縣","臺中市", "彰化縣","南投縣","雲林縣","嘉義縣","嘉義市","臺南市","高雄市","屏東縣","花蓮縣","臺東縣", "澎湖縣","金門縣","連江縣"]
    var orginalanimalResults = [Animal]()
    var animalResults = [Animal]()
    var activityIndicator: UIActivityIndicatorView!
    let userDefaults = UserDefaults.standard
    override func viewDidLoad() {
        setupDropDowns()
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = UIColor.darkGray
        activityIndicator.center = self.tableView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        self.navigationController?.view.addSubview(activityIndicator)
        
        if let urlStr = OpenDataUrl.animal.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr) {
            print(url)

            let task = URLSession.shared.dataTask(with: url) { (data, reponse, error) in
                let decoder = JSONDecoder()
                if let data = data, let animalResult = try? decoder.decode([Animal].self, from: data) {
                    self.orginalanimalResults =                      animalResult.filter{$0.album_file != ""}
                    self.filter()
                    DispatchQueue.main.async {
                        self.tableView.reloadDataSmoothly()
                        self.activityIndicator.stopAnimating()
                    }
                }
            }
            task.resume()
        }
    }
    
    
    // MARK: - Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showAnimalDetail"{
            if let indexPath = tableView.indexPathForSelectedRow{
                let destinationController = segue.destination as! AnimalDetailViewController
                destinationController.animalData = animalResults[indexPath.row]
                destinationController.hidesBottomBarWhenPushed = true

   
            }
        }
    }
    

}
extension AnimalViewController{
    
    //MARK: - Actions
    @IBAction func typefilter(_ sender: AnyObject){
        typeDropDown.show()
    }
    @IBAction func sexfilter(_ sender: AnyObject){
        sexDropDown.show()
    }
    @IBAction func bodytypefilter(_ sender: AnyObject){
        bodytypeDropDown.show()
    }
    @IBAction func agefilter(_ sender: AnyObject){
        ageDropDown.show()
    }
    @IBAction func cityfilter(_ sender: AnyObject){
        cityDropDown.show()
    }
    //恢復預設篩選
    @IBAction func resetfilter(_ sender: UIButton){
        typeButton.setTitle("不限", for: .normal)
        sexButton.setTitle("不限", for: .normal)
        bodytypeButton.setTitle("不限", for: .normal)
        ageButton.setTitle("不限", for: .normal)
        cityButton.setTitle("全部縣市", for: .normal)
        self.animalResults = self.orginalanimalResults
        
        DispatchQueue.main.async {
            self.tableView.reloadDataSmoothly()
        }
        userDefaults.set(typeButton.currentTitle, forKey: "type")
        userDefaults.set(sexButton.currentTitle, forKey: "sex")
        userDefaults.set(bodytypeButton.currentTitle, forKey: "bodytype")
        userDefaults.set(ageButton.currentTitle, forKey: "age")
        userDefaults.set(cityButton.currentTitle, forKey: "city")
        
    }
    //自動帶入上一次設定的篩選條件
    func filter()
    {
        if (userDefaults.string(forKey: "type") == nil)
        {
            userDefaults.set("不限", forKey: "type")
        }
        if (userDefaults.string(forKey: "sex") == nil)
        {
            userDefaults.set("不限", forKey: "sex")
            
        }
        if (userDefaults.string(forKey: "bodytype") == nil)
        {
            userDefaults.set("不限", forKey: "bodytype")
        }
        if (userDefaults.string(forKey: "age") == nil)
        {
            userDefaults.set("不限", forKey: "age")
        }
        if (userDefaults.string(forKey: "city") == nil)
        {
            userDefaults.set("全部縣市", forKey: "city")
        }

        var results = [Animal]()
        results = self.orginalanimalResults
        DispatchQueue.main.async {
            if (self.typeButton.currentTitle == "不限")
            {
                self.animalResults = results
            }
            else
            {
                results = results.filter{$0.animal_kind == kindDict[self.typeButton.currentTitle!]}
                self.animalResults = results
            }
            if (self.sexButton.currentTitle == "不限")
            {
                self.animalResults = results
            }
            else
            {
                results = results.filter{$0.animal_sex == sexDict[self.sexButton.currentTitle!]}
                self.animalResults = results
            }
            if (self.bodytypeButton.currentTitle == "不限")
            {
                self.animalResults = results
            }
            else
            {
                results = results.filter{$0.animal_bodytype == bodyTypeDict[self.bodytypeButton.currentTitle!]}
                self.animalResults = results
            }
            if (self.ageButton.currentTitle == "不限")
            {
                self.animalResults = results
            }
            else
            {
                results = results.filter{$0.animal_age == ageDict[self.ageButton.currentTitle!]}
                self.animalResults = results
            }
            if (self.cityButton.currentTitle == "全部縣市")
            {
                self.animalResults = results
            }
            else
            {
                results = results.filter{$0.animal_area_pkid == pickercity[self.cityButton.currentTitle!]}
                self.animalResults = results
            }

        }
        
    }
    //根據篩選條件搜尋符合資料
    @IBAction func filterButton(_ sender: UIButton){
        
        
        var results = [Animal]()
        results = self.orginalanimalResults
        if (typeButton.currentTitle == "不限")
        {
            self.animalResults = results
        }
        else
        {
            results = results.filter{$0.animal_kind == kindDict[typeButton.currentTitle!]}
            self.animalResults = results
        }
        if (sexButton.currentTitle == "不限")
        {
            self.animalResults = results
        }
        else
        {
            results = results.filter{$0.animal_sex == sexDict[sexButton.currentTitle!]}
            self.animalResults = results
        }
        if (bodytypeButton.currentTitle == "不限")
        {
            self.animalResults = results
        }
        else
        {
            results = results.filter{$0.animal_bodytype == bodyTypeDict[bodytypeButton.currentTitle!]}
            self.animalResults = results
        }
        if (ageButton.currentTitle == "不限")
        {
            self.animalResults = results
        }
        else
        {
            results = results.filter{$0.animal_age == ageDict[ageButton.currentTitle!]}
            self.animalResults = results
        }
        if (cityButton.currentTitle == "全部縣市")
        {
            self.animalResults = results
        }
        else
        {
            results = results.filter{$0.animal_area_pkid == pickercity[cityButton.currentTitle!]}
            self.animalResults = results
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadDataSmoothly()
        }
        //儲存篩選條件
        userDefaults.set(typeButton.currentTitle, forKey: "type")
        userDefaults.set(sexButton.currentTitle, forKey: "sex")
        userDefaults.set(bodytypeButton.currentTitle, forKey: "bodytype")
        userDefaults.set(ageButton.currentTitle, forKey: "age")
        userDefaults.set(cityButton.currentTitle, forKey: "city")
        //UserDefaults.standard.synchronize()
        

    }
    func setupDefaultDropDown() {
        DropDown.setupDefaultAppearance()
        
        dropDowns.forEach {
            $0.cellNib = UINib(nibName: "DropDownCell", bundle: Bundle(for: DropDownCell.self))
            $0.customCellConfiguration = nil
        }
    }
    //MARK: - Setup
    func setupDropDowns(){
        setuptypeDropDown()
        setupsexDropDown()
        setupsizeDropDown()
        setupbodytypeDropDown()
        setupcityDropDown()
    }
    func setuptypeDropDown(){
        typeDropDown.anchorView = typeButton
        
        typeDropDown.bottomOffset = CGPoint(x: 0, y: typeButton.bounds.height)
        
        typeDropDown.dataSource = ["不限","狗","貓"]
        typeButton.setTitle(userDefaults.string(forKey: "type"), for: .normal)
        typeDropDown.selectionAction = { [weak self] (index, item) in
            self?.typeButton.setTitle(item, for: .normal)
        }
    }
    func setupsexDropDown(){
        sexDropDown.anchorView = sexButton
        
        sexDropDown.bottomOffset = CGPoint(x: 0, y: sexButton.bounds.height)
        sexButton.setTitle(userDefaults.string(forKey: "sex"), for: .normal)
        sexDropDown.dataSource = ["不限","公","母"]
        sexDropDown.selectionAction = { [weak self] (index, item) in
            self?.sexButton.setTitle(item, for: .normal)
        }
    }
    func setupbodytypeDropDown(){
        bodytypeDropDown.anchorView = bodytypeButton
        
        bodytypeDropDown.bottomOffset = CGPoint(x: 0, y: bodytypeButton.bounds.height)
        bodytypeButton.setTitle(userDefaults.string(forKey: "bodytype"), for: .normal)
        bodytypeDropDown.dataSource = ["不限","小型","中型","大型"]
                bodytypeDropDown.selectionAction = { [weak self] (index, item) in
            self?.bodytypeButton.setTitle(item, for: .normal)
        }
    }
    func setupsizeDropDown(){
        ageDropDown.anchorView = ageButton
        
        ageDropDown.bottomOffset = CGPoint(x: 0, y: ageButton.bounds.height)
        ageButton.setTitle(userDefaults.string(forKey: "age"), for: .normal)
        ageDropDown.dataSource = ["不限","幼年","成年"]
        ageDropDown.selectionAction = { [weak self] (index, item) in
            self?.ageButton.setTitle(item, for: .normal)
        }
    }
    func setupcityDropDown(){
        cityDropDown.anchorView = cityButton
        
        cityDropDown.bottomOffset = CGPoint(x: 0, y: cityButton.bounds.height)
        
        cityDropDown.dataSource = ["全部縣市","臺北市","新北市","基隆市","宜蘭縣","桃園縣","新竹縣","新竹市","苗栗縣","臺中市", "彰化縣","南投縣","雲林縣","嘉義縣","嘉義市","臺南市","高雄市","屏東縣","花蓮縣","臺東縣", "澎湖縣","金門縣","連江縣"]
        cityButton.setTitle(userDefaults.string(forKey: "city"), for: .normal)

        cityDropDown.selectionAction = { [weak self] (index, item) in
            self?.cityButton.setTitle(item, for: .normal)
        }
    }
    func updateData(){
        
        if (((typeButton.currentTitle == "不限") || (typeButton.currentTitle == "類型")) && ((sexButton.currentTitle == "不限") || (sexButton.currentTitle == "性別")) && ((bodytypeButton.currentTitle == "不限") || (bodytypeButton.currentTitle == "體型")) && ((ageButton.currentTitle == "不限") || (ageButton.currentTitle == "年齡")) && ((cityButton.currentTitle == "全部縣市") || (cityButton.currentTitle == "所在縣市")))
        {
            self.animalResults = self.orginalanimalResults
            
        }
        else if (((typeButton.currentTitle == "不限") || (typeButton.currentTitle == "類型")) && ((sexButton.currentTitle == "不限") || (sexButton.currentTitle == "性別")) && ((bodytypeButton.currentTitle == "不限") || (bodytypeButton.currentTitle == "體型")) && ((ageButton.currentTitle == "不限") || (ageButton.currentTitle == "年齡")))
        {
            self.animalResults = self.orginalanimalResults.filter{$0.animal_area_pkid == pickercity[cityButton.currentTitle!]}
            
        }
        else if (((typeButton.currentTitle == "不限") || (typeButton.currentTitle == "類型")) && ((sexButton.currentTitle == "不限") || (sexButton.currentTitle == "性別")) && ((bodytypeButton.currentTitle == "不限") || (bodytypeButton.currentTitle == "體型"))  && ((cityButton.currentTitle == "全部縣市") || (cityButton.currentTitle == "所在縣市")))
        {
            self.animalResults = self.orginalanimalResults.filter{$0.animal_age == ageDict[ageButton.currentTitle!]}
        }
        else if (((typeButton.currentTitle == "不限") || (typeButton.currentTitle == "類型")) && ((sexButton.currentTitle == "不限") || (sexButton.currentTitle == "性別")) && ((ageButton.currentTitle == "不限") || (ageButton.currentTitle == "年齡")) && ((cityButton.currentTitle == "全部縣市") || (cityButton.currentTitle == "所在縣市")))
        {
            self.animalResults = self.orginalanimalResults.filter{$0.animal_bodytype == bodyTypeDict[bodytypeButton.currentTitle!]}
            
        }
        else if (((typeButton.currentTitle == "不限") || (typeButton.currentTitle == "類型")) && ((bodytypeButton.currentTitle == "不限") || (bodytypeButton.currentTitle == "體型")) && ((ageButton.currentTitle == "不限") || (ageButton.currentTitle == "年齡")) && ((cityButton.currentTitle == "全部縣市") || (cityButton.currentTitle == "所在縣市")))
        {
            self.animalResults = self.orginalanimalResults.filter{$0.animal_sex == sexDict[sexButton.currentTitle!]}
        }
        else if (((sexButton.currentTitle == "不限") || (sexButton.currentTitle == "性別")) && ((bodytypeButton.currentTitle == "不限") || (bodytypeButton.currentTitle == "體型")) && ((ageButton.currentTitle == "不限") || (ageButton.currentTitle == "年齡")) && ((cityButton.currentTitle == "全部縣市") || (cityButton.currentTitle == "所在縣市")))
        {
            self.animalResults = self.orginalanimalResults.filter{$0.animal_kind  == kindDict[typeButton.currentTitle!]}
        }
        else if (((typeButton.currentTitle == "不限") || (typeButton.currentTitle == "類型")) && ((sexButton.currentTitle == "不限") || (sexButton.currentTitle == "性別")) && ((bodytypeButton.currentTitle == "不限") || (bodytypeButton.currentTitle == "體型")) )
        {
            
            self.animalResults = self.orginalanimalResults.filter{$0.animal_age == ageDict[ageButton.currentTitle!] && $0.animal_area_pkid == pickercity[cityButton.currentTitle!]}
        }
        
        else if cityButton.currentTitle == "全部縣市"
        {
            self.animalResults = self.orginalanimalResults.filter{$0.animal_kind == kindDict[typeButton.currentTitle!] && $0.animal_sex == sexDict[sexButton.currentTitle!] && $0.animal_bodytype == bodyTypeDict[bodytypeButton.currentTitle!] && $0.animal_age == ageDict[ageButton.currentTitle!]}

        }else if ageButton.currentTitle == "不限"
        {
            self.animalResults = self.orginalanimalResults.filter{$0.animal_kind == kindDict[typeButton.currentTitle!] && $0.animal_sex == sexDict[sexButton.currentTitle!] && $0.animal_bodytype == bodyTypeDict[bodytypeButton.currentTitle!] && $0.animal_area_pkid == pickercity[cityButton.currentTitle!]}
        }else if bodytypeButton.currentTitle == "不限"
        {
            self.animalResults = self.orginalanimalResults.filter{$0.animal_kind == kindDict[typeButton.currentTitle!] && $0.animal_sex == sexDict[sexButton.currentTitle!] && $0.animal_age == ageDict[ageButton.currentTitle!] && $0.animal_area_pkid ==  pickercity[cityButton.currentTitle!]}
        }else if sexButton.currentTitle == "不限"
        {
            self.animalResults = self.orginalanimalResults.filter{$0.animal_kind == kindDict[typeButton.currentTitle!] && $0.animal_bodytype == bodyTypeDict[bodytypeButton.currentTitle!] && $0.animal_age == ageDict[ageButton.currentTitle!] && $0.animal_area_pkid ==  pickercity[cityButton.currentTitle!]}
            
        }else if typeButton.currentTitle == "不限"
        {
            self.animalResults = self.orginalanimalResults.filter{$0.animal_sex == sexDict[sexButton.currentTitle!] && $0.animal_bodytype == bodyTypeDict[bodytypeButton.currentTitle!] && $0.animal_age == ageDict[ageButton.currentTitle!] && $0.animal_area_pkid ==  pickercity[cityButton.currentTitle!]}
        }
        else
        {
            self.animalResults = self.orginalanimalResults.filter{$0.animal_kind == kindDict[typeButton.currentTitle!] && $0.animal_sex == sexDict[sexButton.currentTitle!] && $0.animal_bodytype == bodyTypeDict[bodytypeButton.currentTitle!] && $0.animal_age == ageDict[ageButton.currentTitle!] && $0.animal_area_pkid == pickercity[cityButton.currentTitle!
                ]}
        }
        DispatchQueue.main.async {
            self.tableView.reloadDataSmoothly()
        }
    }
}
extension UITableView {
  func reloadDataSmoothly() {
    UIView.setAnimationsEnabled(false)
    CATransaction.begin()

    CATransaction.setCompletionBlock { () -> Void in
      UIView.setAnimationsEnabled(true)
    }

    reloadData()
    beginUpdates()
    endUpdates()

    CATransaction.commit()
  }
}
// MARK: -TableView
extension AnimalViewController: UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
//        filterButton.setTitle("浪浪數量：\(animalResults.count)",for: .normal)
        navigationItem.title = "浪浪數量:\(animalResults.count)"
        return animalResults.count
        


    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            // #warning Incomplete implementation, return the number of rows
             guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing:AnimalTableViewCell.self), for: indexPath) as? AnimalTableViewCell else {
                 return AnimalTableViewCell()
             }
             cell.selectionStyle = .none

             let animalData = animalResults[indexPath.row]
             let imageUrl = URL(string: animalData.album_file)
             let processor = DownsamplingImageProcessor(size: cell.animalimage.bounds.size)
                 |> RoundCornerImageProcessor(cornerRadius: 10)
             cell.animalimage.kf.indicatorType = .activity
             cell.animalimage.kf.setImage(
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
             cell.city.text = cityDict[String(animalData.animal_area_pkid)]!
             cell.sex.text = sex[String(animalData.animal_sex)]!
            // cell.id.text = "ID: " + String(animalData.animal_id)
             cell.bodytype.text =  bodytype[String(animalData.animal_bodytype)]!
             

             return cell

    }
    
}
