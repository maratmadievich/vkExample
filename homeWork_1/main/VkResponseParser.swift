//
//  VkResponseParser.swift
//  homeWork_1
//
//  Created by Admin on 07.11.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class VkResponseParser {
    
    static let instance = VkResponseParser()
    private init(){}
    
    
    func parseFriends(result: Result<Any>) -> [VkFriend] {
        var friends = [VkFriend]()
        
        switch result {
        case .success(let value):
            let json = JSON(value)
            if let responses = json["response"].array {
                for response in responses {
                    if (response.dictionary != nil) {
                        let friend = VkFriend()
                        friend.uid = response["uid"].intValue
                        friend.online = response["online"].intValue
                        friend.user_id = response["user_id"].intValue
                        friend.photo = response["photo_100"].stringValue
                        friend.nickname = response["nickname"].stringValue
                        friend.last_name = response["last_name"].stringValue
                        friend.first_name = response["first_name"].stringValue
                        friends.append(friend)
                    } else {
                        print("is not Response")
                    }
                }
            } else {
                print ("parseFriends - error: какой-то косячок")
            }
            break
            
        case .failure(let error):
            print ("parseFriends - error: \(error.localizedDescription)")
            break
        }
        RealmWorker.instance.saveFriends(friends)
        return friends
    }
    
    func parseGroups(result: Result<Any>) -> [VkGroup] {
        var groups = [VkGroup]()
        
        switch result {
        case .success(let value):
            let json = JSON(value)
            if let responses = json["response"].array {
                for response in responses {
                    if (response.dictionary != nil) {
                        let group = VkGroup()
                        group.gid = response["gid"].intValue
                        group.is_admin = response["is_admin"].intValue
                        group.is_closed = response["is_closed"].intValue
                        group.is_member = response["is_member"].intValue
                        group.name = response["name"].stringValue
                        group.photo = response["photo"].stringValue
                        group.photoBig = response["photo_big"].stringValue
                        group.photoMedium = response["photo_medium"].stringValue
                        group.type = response["type"].stringValue
                        groups.append(group)
                    } else {
                        print("is not Json")
                    }
                }
            } else {
                print ("parseGroups - error: какой-то косячок")
            }
            break
            
        case .failure(let error):
            print ("parseGroups - error: \(error.localizedDescription)")
            break
        }
        RealmWorker.instance.saveGroups(groups)
        return groups
    }
    
    func parsePhotos(result: Result<Any>) -> [VkPhoto] {
        var photos = [VkPhoto]()
        
        switch result {
        case .success(let value):
            let json = JSON(value)
            if let responses = json["response"].array {
                for response in responses {
                    if (response.dictionary != nil) {
                        let photo = VkPhoto()
                        photo.pid = response["pid"].intValue
                        photo.aid = response["aid"].intValue
                        photo.created = response["created"].intValue
                        photo.height = response["height"].intValue
                        photo.width = response["width"].intValue
                        photo.ownerId = response["owner_id"].intValue
                        photo.photo = response["src"].stringValue
                        photo.photoBig = response["src_big"].stringValue
                        photo.text = response["text"].stringValue
                        
                        photo.likes = VkLikes()
                        photo.likes.count = response["likes"]["count"].intValue
                        photo.likes.user_likes = response["likes"]["user_likes"].intValue
                        
                        photo.reposts = VkReposts()
                        photo.reposts.count = response["reposts"]["count"].intValue
                        photos.append(photo)
                    } else {
                        print("is not Response")
                    }
                }
            } else {
                print ("parsePhotos - error: какой-то косячок")
            }
            break
            
        case .failure(let error):
            print ("parsePhotos - error: \(error.localizedDescription)")
            break
        }
//        RealmWorker.instance.savePhotos(photos)
        return photos
    }
    
}
