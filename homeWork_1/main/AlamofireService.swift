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
}

class AlamofireService {
    
    static let instance = AlamofireService()
    private init(){}

    
    // //Друзья
    func getFriends(delegate: VkApiViewControllerDelegate) {
        let method = "friends.get"
        let fullRow = "\(GlobalConstants.vkApi)\(method)"
        let params: Parameters = [
            "access_token": Session.instance.token,
            "fields": "id,nickname,photo_100",
            "v": "3.0",
        ]
        
        Alamofire.request(fullRow, method: .get, parameters: params)
            .responseJSON { response in
                delegate.returnFriends(
                    VkResponseParser.instance.parseFriends(
                        result: response.result))
                
        }
    }
    
    
    // //Группы
    func getGroups(delegate: VkApiViewControllerDelegate) {
        let method = "groups.get"
        let fullRow = "\(GlobalConstants.vkApi)\(method)"//&v5.87
        let params: Parameters = [
            "access_token": Session.instance.token,
            "fields": "id,name",
            "extended": "1",
            "v": "3.0",
            "count":"50"
        ]
        
        Alamofire.request(fullRow, method: .get, parameters: params)
            .responseJSON { response in
                delegate.returnGroups(
                    VkResponseParser.instance.parseGroups(
                        result: response.result))
        }
    }
    
    
    // //Группы Поиск
    func searchGroups(delegate: VkApiViewControllerDelegate) {
        let method = "groups.search"
        let searchString = "GeekBrains"
        let fullRow = "\(GlobalConstants.vkApi)\(method)"//&v5.87
        let params: Parameters = [
            "access_token": Session.instance.token,
            "q": searchString,
            "extended": "1",
            "v": "3.0"
        ]
        Alamofire.request(fullRow, method: .get, parameters: params)
            .responseJSON { response in
                delegate.returnGroups(
                    VkResponseParser.instance.parseGroups(
                        result: response.result))
        }
    }
    
    
    func getPhotos(delegate: VkApiViewControllerDelegate) {
        let session = Session.instance
        let method = "photos.getAll"
        let fullRow = "\(GlobalConstants.vkApi)\(method)?access_token=\(session.token)&v=3.0&extended=1&count=100"//&v5.87
        
        let params: Parameters = [
            "access_token": Session.instance.token,
            "extended": "1",
            "v": "3.0",
            "count":"100"
        ]
        
        Alamofire.request(fullRow, method: .get, parameters: params)
            .responseJSON { response in
                delegate.returnPhotos(
                    VkResponseParser.instance.parsePhotos(
                        result: response.result))
        }
    }
    
    func getPhotosBy(_ id: Int, delegate: VkApiViewControllerDelegate) {
        let session = Session.instance
        let method = "photos.getAll"
        let fullRow = "\(GlobalConstants.vkApi)\(method)?access_token=\(session.token)&v=3.0&extended=1&count=100"//&v5.87
        
        let params: Parameters = [
            "access_token": Session.instance.token,
            "extended": "1",
            "v": "3.0",
            "owner_id":"\(id)",
            "count":"100"//,
            //            "album_id":"saved"
        ]
        
        Alamofire.request(fullRow, method: .get, parameters: params)
            .responseJSON { response in
                delegate.returnPhotos(
                    VkResponseParser.instance.parsePhotos(
                        result: response.result))
        }
    }
    
    
}

