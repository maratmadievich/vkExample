//
//  VkGroup.swift
//  homeWork_1
//
//  Created by Admin on 29.10.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit
import RealmSwift

class VkGroup: Object {
    
    @objc dynamic var gid = 0
    @objc dynamic var is_admin = 0
    @objc dynamic var is_closed = 0
    @objc dynamic var is_member = 0
    @objc dynamic var name = ""
    @objc dynamic var type = ""
    @objc dynamic var photo = ""
    @objc dynamic var photoBig = ""
    @objc dynamic var screenName = ""
    @objc dynamic var photoMedium = ""
    
    override static func primaryKey() -> String? {
        return "gid"
    }
    
    override static func indexedProperties() -> [String] {
        return ["name", "is_member"]
    }
    
    
    func getType() -> String {
        switch type {
        case "event":
            return "Мероприятие"
        case "group":
            return "Группа"
        case "page":
            return "Публичная страница"
        default:
            return ""
        }
    }
}
