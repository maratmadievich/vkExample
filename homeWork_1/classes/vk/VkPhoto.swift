//
//  VkPhoto.swift
//  homeWork_1
//
//  Created by Admin on 29.10.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit

struct VkPhoto: Codable {

    var pid: Int
    var aid: Int
    var created: Int
    var height: Int
    var width: Int
    var ownerId: Int
    var photo: String
    var photoBig: String
    var text: String
    var likes: VkLikes?
    var reposts: VkReposts?

    enum CodingKeys: String, CodingKey {
        case photo = "src"
        case photoBig = "src_big"
        case pid
        case aid
        case created
        case height
        case width
        case ownerId = "owner_id"
        case text
        case likes
        case reposts
    }

    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            self.pid = try values.decode(Int.self, forKey: .pid)
            self.aid = try values.decode(Int.self, forKey: .aid)
            self.created = try values.decode(Int.self, forKey: .created)
            self.height = try values.decode(Int.self, forKey: .height)
            self.width = try values.decode(Int.self, forKey: .width)
            self.ownerId = try values.decode(Int.self, forKey: .ownerId)
        
            self.photo = try values.decode(String.self, forKey: .photo)
            self.photoBig = try values.decode(String.self, forKey: .photoBig)
            self.text = try values.decode(String.self, forKey: .text)
            
            self.likes = try values.decode(VkLikes.self, forKey: .likes)
            self.reposts = try values.decode(VkReposts.self, forKey: .reposts)
        }
        catch {
            print("maybe first item")
            self.pid = -1
            self.aid = -1
            self.created = -1
            self.height = -1
            self.width = -1
            self.ownerId = -1
            
            self.photo = ""
            self.photoBig = ""
            self.text = ""
        }
    }
    
    public func likeCount() -> Int {
        if let likes = likes {
            return likes.count
        } else {
            return 0
        }
    }
    
    public func repostCount() -> Int {
        if let reposts = reposts {
            return reposts.count
        } else {
            return 0
        }
    }
    
}

struct VkLikes: Codable {
    
    var count: Int
    var user_likes: Int
}

struct VkReposts: Codable {
    
    var count: Int
}

struct VkPhotoResponse: Codable {

    var photos:[VkPhoto]

    enum CodingKeys: String, CodingKey {
        case photos = "response"
    }

    public mutating func clean() {
        for (index, photo) in self.photos.enumerated() {
            if photo.pid < 0 {
                self.photos.remove(at: index)
                break
            }
        }
    }
}
