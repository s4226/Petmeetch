//
//  Animal.swift
//  Petmeetch
//
//  Created by Peiru Chiu on 2020/8/12.
//  Copyright © 2020 Peiru Chiu. All rights reserved.
//

import Foundation

struct Animal: Codable{
    var animal_id: Int
    var animal_subid: String
    var animal_area_pkid: Int
    var animal_shelter_pkid: Int
    var animal_place: String
   var animal_kind: String
    var animal_sex: String
    var animal_bodytype: String
    var animal_colour: String
    var animal_age: String
    var animal_sterilization: String
    var animal_bacterin: String
    var animal_foundplace: String
    var animal_title: String
    var animal_status: String
    var animal_remark: String
    var animal_caption: String
    var animal_opendate: String
    var animal_closeddate: String
    var animal_update: String
    var animal_createtime: String
    var shelter_name: String
    var album_file: String
    var album_update: String
    var cDate: String
    var shelter_address: String
    var shelter_tel: String
}
//extension Animal: Hashable {
//    static func == (lhs: Animal, rhs: Animal) -> Bool {
//        return lhs.animal_id == rhs.animal_id && lhs.animal_subid == rhs.animal_subid
//    }
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(animal_id)
//        hasher.combine(animal_subid)
//    }
//}

