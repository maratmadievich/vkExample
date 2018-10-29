//
//  VkFriend.swift
//  homeWork_1
//
//  Created by Admin on 29.10.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit

struct VkFriend: Codable {
    
    let first_name: String
    let last_name: String
    let nickname: String?
    let online: Int
    let uid: Int
    let user_id: Int
}


struct VkFriendResponse: Codable {
    
    let friends:[VkFriend]
    
    enum CodingKeys: String, CodingKey {
        case friends = "response"
    }
}
