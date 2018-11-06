//
//  VkFriend.swift
//  homeWork_1
//
//  Created by Admin on 29.10.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit
import RealmSwift

//struct VkFriend: Codable {
//
//    let first_name: String
//    let last_name: String
//    let nickname: String?
//    let online: Int
//    let uid: Int
//    let user_id: Int
//}

//class VkFriend: Object, Codable {
//
//    @objc dynamic var first_name: String
//    @objc dynamic var last_name: String
//    @objc dynamic var nickname: String?
//    @objc dynamic var online: Int
//    @objc dynamic var uid: Int
//    @objc dynamic var user_id: Int
//}


class VkFriend: Object {//, Codable : Object
    
    @objc dynamic var uid: Int = 0
    @objc dynamic var online: Int = 0
    @objc dynamic var user_id: Int = 0
    @objc dynamic var nickname: String = ""
    @objc dynamic var last_name: String = ""
    @objc dynamic var first_name: String = ""
    
//    convenience required init() {
//        first_name = ""
//        last_name = ""
//        nickname = ""
//        online = -1
//        uid = -1
//        user_id = -1
//    }
}


//struct VkFriendResponse: Codable {
//
//    let friends:[VkFriend]
//
//    enum CodingKeys: String, CodingKey {
//        case friends = "response"
//    }
//}
