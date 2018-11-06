//
//  AlamofireService.swift
//  homeWork_1
//
//  Created by Admin on 06.11.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol VkApiViewControllerDelegate {
    
    func returnString(text: String)
    func returnFriends(_ friends: [VkFriend])
    func returnGroups(_ groups: [VkGroup])
    func returnPhotos(_ photos: [VkPhoto])
//    func returnString(text: String)
//
//    func returnString(text: String)
}


extension UIViewController {
    
    // //Друзья
    func getFriends(needString: Bool, delegate: VkApiViewControllerDelegate) {
        let session = Session.instance
        let method = "friends.get"
        let fullRow = "\(GlobalConstants.vkApi)\(method)?access_token=\(session.token)&v=3.0&fields=id,nickname"
        
        Alamofire.request(fullRow, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                if (needString) {
                    delegate.returnString(text: "\(response.description)")
                } else {
                    delegate.returnFriends(self.parseFriends(result: response.result))
                }
        }
    }
    
    
    // //Группы
    func getGroups(needString: Bool, delegate: VkApiViewControllerDelegate) {
        let session = Session.instance
        let method = "groups.get"
        let fullRow = "\(GlobalConstants.vkApi)\(method)?access_token=\(session.token)&v=3.0&extended=1&fields=id,name&count=50"//&v5.87
        
        Alamofire.request(fullRow, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                if (needString) {
                    delegate.returnString(text: "\(response.description)")
                } else {
                    delegate.returnGroups(self.parseGroups(result: response.result))
                }
                
        }
    }
    
    
    // //Группы Поиск
    func searchGroups(needString: Bool, delegate: VkApiViewControllerDelegate) {
        let session = Session.instance
        let method = "groups.search"
        let searchString = "GeekBrains"
        let fullRow = "\(GlobalConstants.vkApi)\(method)?access_token=\(session.token)&v=3.0&extended=1&q=\(searchString)"//&v5.87
        
        Alamofire.request(fullRow, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                if (needString) {
                    delegate.returnString(text: "\(response.description)")
                } else {
                    delegate.returnGroups(self.parseGroups(result: response.result))
                }
        }
    }
    
    
    func getPhotos(needString: Bool, delegate: VkApiViewControllerDelegate) {
        let session = Session.instance
        let method = "photos.getAll"
        let searchString = "GeekBrains"
        let fullRow = "\(GlobalConstants.vkApi)\(method)?access_token=\(session.token)&v=3.0&extended=1&count=100"//&v5.87
        
        Alamofire.request(fullRow, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                if (needString) {
                    delegate.returnString(text: "\(response.description)")
                } else {
                    delegate.returnPhotos(self.parsePhotos(result: response.result))
                }
        }
    }
    
    
    
    
    private func parseFriends(result: Result<Any>) -> [VkFriend] {
        var friends = [VkFriend]()
        
        switch result {
        case .success(let value):
            let json = JSON(value)
            if let responses = json["response"].array {
                for response in responses {
                    var needSearch = true
                    let friend = VkFriend()
                    if let uid = response["uid"].int {
                        friend.uid = uid
                    } else {
                        needSearch = false
                    }
                    if needSearch {
                        if let user_id = response["user_id"].int {
                            friend.user_id = user_id
                        }
                        if let online = response["online"].int {
                            friend.online = online
                        }
                        if let first_name = response["first_name"].string {
                            friend.first_name = first_name
                        }
                        if let last_name = response["last_name"].string {
                            friend.last_name = last_name
                        }
                        if let nickname = response["nickname"].string {
                            friend.nickname = nickname
                        }
                        friends.append(friend)
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
        return friends
    }
    
    
    private func parseGroups(result: Result<Any>) -> [VkGroup] {
        var groups = [VkGroup]()
        
        switch result {
        case .success(let value):
            let json = JSON(value)
            if let responses = json["response"].array {
                for response in responses {
                    var needSearch = true
                    let group = VkGroup()
                    if let gid = response["gid"].int {
                        group.gid = gid
                    } else {
                        needSearch = false
                    }
                    if needSearch {
                        if let is_admin = response["is_admin"].int {
                            group.is_admin = is_admin
                        }
                        if let is_closed = response["is_closed"].int {
                            group.is_closed = is_closed
                        }
                        if let is_member = response["is_member"].int {
                            group.is_member = is_member
                        }
                        if let name = response["name"].string {
                            group.name = name
                        }
                        if let photo = response["photo"].string {
                            group.photo = photo
                        }
                        if let photo_big = response["photo_big"].string {
                            group.photoBig = photo_big
                        }
                        if let photo_medium = response["photo_medium"].string {
                            group.photoMedium = photo_medium
                        }
                        if let type = response["type"].string {
                            group.type = type
                        }
                        groups.append(group)
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
        return groups
    }
    
    
    private func parsePhotos(result: Result<Any>) -> [VkPhoto] {
        var photos = [VkPhoto]()
        
        switch result {
        case .success(let value):
            let json = JSON(value)
            if let responses = json["response"].array {
                for response in responses {
                    var needSearch = true
                    let photo = VkPhoto()
                    if let pid = response["pid"].int {
                        photo.pid = pid
                    } else {
                        needSearch = false
                    }
                    if needSearch {
                        if let aid = response["aid"].int {
                            photo.aid = aid
                        }
                        if let created = response["created"].int {
                            photo.created = created
                        }
                        if let height = response["height"].int {
                            photo.height = height
                        }
                        if let width = response["width"].int {
                            photo.width = width
                        }
                        if let owner_id = response["owner_id"].int {
                            photo.ownerId = owner_id
                        }
                        if let src = response["src"].string {
                            photo.photo = src
                        }
                        if let src_big = response["src_big"].string {
                            photo.photoBig = src_big
                        }
                        if let text = response["text"].string {
                            photo.text = text
                        }
                        if let likes = response["likes"].dictionary {
                            if let count = likes["count"]?.int {
                                photo.likes?.count = count
                            }
                            if let user_likes = likes["user_likes"]?.int {
                                photo.likes?.user_likes = user_likes
                            }
                        }
                        if let reposts = response["reposts"].dictionary {
                            if let count = reposts["count"]?.int {
                                photo.reposts?.count = count
                            }
                        }
                        photos.append(photo)
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
        return photos
    }
    
    
    
}
