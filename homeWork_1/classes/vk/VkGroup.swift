//
//  VkGroup.swift
//  homeWork_1
//
//  Created by Admin on 29.10.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit
import RealmSwift

//struct VkGroup: Codable {
//
//    var gid: Int
//    var is_admin: Int
//    var is_closed: Int
//    var is_member: Int
//    var name: String
//    var photo: String
//    var photoBig: String
//    var photoMedium: String
//    var screenName: String
//    var type: String
//
//    enum CodingKeys: String, CodingKey {
//        case photoBig = "photo_big"
//        case photoMedium = "photo_medium"
//        case screenName = "screen_name"
//        case gid
//        case is_admin
//        case is_closed
//        case is_member
//        case name
//        case photo
//        case type
//    }
//
//    init(from decoder: Decoder) throws {
//        do {
//            let values = try decoder.container(keyedBy: CodingKeys.self)
//            self.gid = try values.decode(Int.self, forKey: .gid)
//            self.is_admin = try values.decode(Int.self, forKey: .is_admin)
//            self.is_closed = try values.decode(Int.self, forKey: .is_closed)
//            self.is_member = try values.decode(Int.self, forKey: .is_member)
//            self.name = try values.decode(String.self, forKey: .name)
//            self.photo = try values.decode(String.self, forKey: .photo)
//            self.photoBig = try values.decode(String.self, forKey: .photoBig)
//            self.photoMedium = try values.decode(String.self, forKey: .photoMedium)
//            self.screenName = try values.decode(String.self, forKey: .screenName)
//            self.type = try values.decode(String.self, forKey: .type)
//        }
//        catch {
//            print("maybr first item")
//            self.gid = -1
//            self.is_admin = -1
//            self.is_closed = -1
//            self.is_member = -1
//            self.name = ""
//            self.photo = ""
//            self.photoBig = ""
//            self.photoMedium = ""
//            self.screenName = ""
//            self.type = ""
//        }
//    }
//
//
//}

//struct VkGroupResponse: Codable {
//
//    var groups:[VkGroup]
//
//    enum CodingKeys: String, CodingKey {
//        case groups = "response"
//    }
//
//    public mutating func clean() {
//        for (index, group) in self.groups.enumerated() {
//            if group.gid < 0 {
//                self.groups.remove(at: index)
//                break
//            }
//        }
//    }
//
//    init(from decoder: Decoder) throws {
//        do {
//            let values = try decoder.container(keyedBy: CodingKeys.self)
//            self.groups = try values.decode([VkGroup].self, forKey: .groups)
//        }
//        catch {
//            print("maybr first item")
//            self.groups = [VkGroup]()
//        }
//    }
//
//
////    public mutating func clean() {
////        for (index, group) in self.groups.enumerated() {
////            if group.gid < 0 {
////                self.groups.remove(at: index)
////                break
////            }
////        }
////    }
//}


class VkGroup: Object {
    
    @objc dynamic var gid: Int = -1
    @objc dynamic var is_admin: Int = -1
    @objc dynamic var is_closed: Int = -1
    @objc dynamic var is_member: Int = -1
    @objc dynamic var name: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var photo: String = ""
    @objc dynamic var photoBig: String = ""
    @objc dynamic var screenName: String = ""
    @objc dynamic var photoMedium: String = ""
    
    
    
    
    
//    init() {
//        gid = -1
//        is_admin = -1
//        is_closed = -1
//        is_member = -1
//        name = ""
//        photo = ""
//        photoBig = ""
//        photoMedium = ""
//        screenName = ""
//        type = ""
//    }
    
    
}
