//
//  VKApiViewController.swift
//  homeWork_1
//
//  Created by Admin on 23.10.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit
import Alamofire
import Foundation

class VKApiViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var buttonShow: UIButton!
    
    private let session = Session.instance
    
    private var type = 0
    private var isLoad = false
    
    private var showText = true
    
    var groups  = [VkGroup]()
    var photos =  [VkPhoto]()
    var friends = [VkFriend]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonText()
    }
    

    @IBAction func buttonShowClicked(_ sender: Any) {
        if (!isLoad) {
            isLoad = !isLoad
            getNewInfo()
        }
    }
    
    
    private func setButtonText() {
        var title = ""
        switch type {
        case 0:
            title = "Вывести друзей"
            break
            
        case 1:
            title = "Вывести группы"
            break
            
        case 2:
            title = "Найти группы (GeekBrains)"
            break
            
        case 3:
            title = "Вывести фотки"
            break
        
        default:
            title = "Вывести"
            break
        }
        buttonShow.setTitle(title, for: .normal)
    }
    
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        showText = sender.selectedSegmentIndex == 0
    }
    
    
//    private func getNewInfo() {
//        let url = "https://api.vk.com/method/"
//        var method = ""
//        var fullRow = ""
//        switch type {
//        case 0:
//            //Друзья
//            method = "friends.get"
//            fullRow = "\(url)\(method)?access_token=\(session.token)&v=3.0&fields=id,nickname"//&v5.87
//            break
//
//        case 1:
//            //Группы
//            method = "groups.get"
//            fullRow = "\(url)\(method)?access_token=\(session.token)&v=3.0&extended=1&fields=id,name&count=50"//&v5.87
//            break
//
//        case 2:
//            //Поиск группы
//            method = "groups.search"
//            let searchString = "GeekBrains"
//            fullRow = "\(url)\(method)?access_token=\(session.token)&v=3.0&extended=1&q=\(searchString)"//&v5.87
//            break
//
//        case 3:
//            //Фото
////            method = "photos.get"
////            fullRow = "\(url)\(method)?access_token=\(session.token)&v=3.0&extended=1&album_id=saved&count=100"//&v5.87
//            method = "photos.getAll"
//            fullRow = "\(url)\(method)?access_token=\(session.token)&v=3.0&extended=1&count=100"//&v5.87
//            break
//
//
//        default:
//            break
//        }
//
//        if (showText) {
//            Alamofire.request(fullRow, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
//                .responseJSON { response in
//
//                    self.showResponse(result: response.result, method: method)
//                    self.isLoad = false
//            }
//        } else {
//            Alamofire.request(fullRow, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
//                .responseData { response in
//                    guard let data = response.result.value else { return }
//                    self.parseResponse(data: data)
//                    self.isLoad = false
//            }
//        }
//        type = (type + 1) % 4
//        setButtonText()
//    }
    
    
    private func getNewInfo() {
        switch type {
        case 0:
            getFriends(needString: showText, delegate: self)
            break
            
        case 1:
            getGroups(needString: showText, delegate: self)
            break
            
        case 2:
            searchGroups(needString: showText, delegate: self)
            break
            
        case 3:
            getPhotos(needString: showText, delegate: self)
            break
            
            
        default:
            break
        }
        type = (type + 1) % 4
        setButtonText()
    }

        
    
//    private func showResponse(result: Result<Any>, method: String) {
////        self.view.isUserInteractionEnabled = true
//        switch result {
//        case .success(let value):
//            self.textView.text = "\(method):\n\(value)"
//            print("\(method):\n\(value)")
//            break
//
//        case .failure(let error):
//            self.textView.text = "\(error.localizedDescription)"
//            break
//        }
//    }
    
    
//    private func parseResponse(data: Data) {
//        do {
//            switch (type + 3) % 4 {
//            case 0:
//                self.friendResponse = try JSONDecoder().decode(VkFriendResponse.self, from: data)
////                print(friendResponse)
//                var text = ""
//                for (index, friend) in self.friendResponse.friends.enumerated() {
//                    text += "friend №\(index + 1)\n"
//                    text += "id: \(friend.uid)\n"
//                    text += "Фамилия: \(friend.last_name)\n"
//                    text += "Имя: \(friend.first_name)\n\n"
//                }
//                self.textView.text = "\(text)"
//                break
//
//            case 1:
//                self.groupResponse = try JSONDecoder().decode(VkGroupResponse.self, from: data)
//                self.groupResponse.clean()
//                //                print(friendResponse)
//                var text = ""
//                for (index, group) in self.groupResponse.groups.enumerated() {
//                    text += "groups №\(index + 1)\n"
//                    text += "id: \(group.gid)\n"
//                    text += "Название: \(group.name)\n"
//                    text += "Фото: \(group.photo)\n\n"
//                }
//                self.textView.text = "\(text)"
//                break
//
//            case 2:
//                self.groupResponse = try JSONDecoder().decode(VkGroupResponse.self, from: data)
//                self.groupResponse.clean()
//                //                print(friendResponse)
//                var text = ""
//                for (index, group) in self.groupResponse.groups.enumerated() {
//                    text += "groups №\(index + 1)\n"
//                    text += "id: \(group.gid)\n"
//                    text += "Название: \(group.name)\n"
//                    text += "Фото: \(group.photo)\n\n"
//                }
//                self.textView.text = "\(text)"
//                break
//
//            case 3:
//                self.photoResponse = try JSONDecoder().decode(VkPhotoResponse.self, from: data)
//                self.photoResponse.clean()
//                var text = ""
//                for (index, photo) in self.photoResponse.photos.enumerated() {
//                    text += "photo №\(index + 1)\n"
//                    text += "id: \(photo.pid)\n"
//                    text += "Название: \(photo.text)\n"
//                    text += "Фото: \(photo.photo)\n"
//                    text += "Лайков: \(photo.likeCount())\n"
//                    text += "Репостов: \(photo.repostCount())\n\n"
//                }
//                self.textView.text = "\(text)"
//                break
//
//            default:
//                break
//            }
//
//        } catch {
//            print(error)
//        }
//    }
    
    
}

extension VKApiViewController: VkApiViewControllerDelegate {
    
    func returnString(text: String) {
        isLoad = !isLoad
        self.textView.text = "Ответ от сервера:\n\(text)"
    }
    
    func returnFriends(_ friends: [VkFriend]) {
        isLoad = !isLoad
        self.friends.removeAll()
        self.friends = friends
        showFriends()
    }
    
    func returnGroups(_ groups: [VkGroup]) {
        isLoad = !isLoad
        self.groups.removeAll()
        self.groups = groups
        showGroups()
    }
    
    func returnPhotos(_ photos: [VkPhoto]) {
        isLoad = !isLoad
        self.photos.removeAll()
        self.photos = photos
        showPhotos()
    }
    
    
    private func showFriends() {
        var text = ""
        for (index, friend) in self.friends.enumerated() {
            text += "friend №\(index + 1)\n"
            text += "id: \(friend.uid)\n"
            text += "Фамилия: \(friend.last_name)\n"
            text += "Имя: \(friend.first_name)\n\n"
        }
        self.textView.text = "\(text)"
    }
    
    private func showGroups() {
        var text = ""
        for (index, group) in self.groups.enumerated() {
            text += "groups №\(index + 1)\n"
            text += "id: \(group.gid)\n"
            text += "Название: \(group.name)\n"
            text += "Фото: \(group.photo)\n\n"
        }
        self.textView.text = "\(text)"
    }
    
    private func showPhotos() {
        var text = ""
        for (index, photo) in self.photos.enumerated() {
            text += "photo №\(index + 1)\n"
            text += "id: \(photo.pid)\n"
            text += "Название: \(photo.text)\n"
            text += "Фото: \(photo.photo)\n"
            text += "Лайков: \(photo.likeCount())\n"
            text += "Репостов: \(photo.repostCount())\n\n"
        }
        self.textView.text = "\(text)"
    }
    
}



