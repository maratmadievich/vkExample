//
//  VKApiViewController.swift
//  homeWork_1
//
//  Created by Admin on 23.10.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit
import Alamofire

class VKApiViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var buttonShow: UIButton!
    
    private let session = Session.instance
    
    private var type = 0
    private var isLoad = false
    
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
    
    
    private func getNewInfo() {
        let url = "https://api.vk.com/method/"
        var method = ""
        var fullRow = ""
        switch type {
        case 0:
            //Друзья
            method = "friends.get"
            fullRow = "\(url)\(method)?access_token=\(session.token)&v=3.0&fields=id,nickname"//&v5.87
            
            Alamofire.request(fullRow, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
                .responseJSON { response in
                    
                    self.parseResponse(result: response.result, method: method)
                    self.isLoad = false
            }
            
            break
            
        case 1:
            //Группы
            method = "groups.get"
            fullRow = "\(url)\(method)?access_token=\(session.token)&v=3.0&extended=1&fields=id,name"//&v5.87
            
            Alamofire.request(fullRow, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
                .responseJSON { response in
                    
                    self.parseResponse(result: response.result, method: method)
                    self.isLoad = false
            }
            break
            
        case 2:
            //Поиск группы
            method = "groups.search"
            let searchString = "GeekBrains"
            fullRow = "\(url)\(method)?access_token=\(session.token)&v=3.0&extended=1&q=\(searchString)"//&v5.87
            
            Alamofire.request(fullRow, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
                .responseJSON { response in
                    
                    self.parseResponse(result: response.result, method: method)
                    self.isLoad = false
            }
            break
            
        case 3:
            //Фото
            method = "photos.get"
            let searchString = "GeekBrains"
            fullRow = "\(url)\(method)?access_token=\(session.token)&v=3.0&extended=1&album_id=saved&count=100"//&v5.87
            
            Alamofire.request(fullRow, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
                .responseJSON { response in
                    
                    self.parseResponse(result: response.result, method: method)
                    self.isLoad = false
            }
            break
            
            
        default:
            break
        }
        type = (type + 1) % 4
        setButtonText()
        
    }
    
    
    
    private func parseResponse(result: Result<Any>, method: String) {
//        self.view.isUserInteractionEnabled = true
        switch result {
        case .success(let value):
            self.textView.text = "\(method):\n\(value)"
            break
            
        case .failure(let error):
            self.textView.text = "\(error.localizedDescription)"
            break
        }    }
    
}
