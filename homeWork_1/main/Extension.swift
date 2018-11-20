//
//  Extension.swift
//  homeWork_1
//
//  Created by Марат Нургалиев on 30.09.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit



/*
 2.1
 Добавить в проект синглтон для хранения данных о текущей сессии – Session
 Добавить в него свойства:
 token: String – для хранения токена в VK,
 userId: Int – для хранения идентификатора пользователя ВК.
 */
class Session {
    
    static let instance = Session()
    
    private init(){}
    
    var token = ""
    var userId = 0
}


struct GlobalConstants {
    
    static var titles = [String]()

    static let defaults = UserDefaults.standard
    
    static let vkApi = "https://api.vk.com/method/"
    
    static func getGroupType(value: Int) -> String {
        let number = value % 4
        switch number {
        case 0:
            return "Cпортивная организация"
        case 1:
            return "Открытая группа"
        case 2:
            return "Интернет-СМИ"
        default:
            return "Кино"
        }
    }
    
    
    static func getGroupName(value: Int) -> String {
        if value < 10 {
            return "Детская группа №\(value)"
        } else if value < 20 {
            return "Мужская группа №\(value)"
        } else if value < 30 {
            return "Женская группа №\(value)"
        }
        return "Группа №\(value)"
        
    }
}


class Group {
    var name = String()
    var type = String()
    var value = Int()
}


@IBDesignable extension UIView {
    
    @IBInspectable var shadowColor: UIColor? {
        set {
            layer.shadowColor = newValue!.cgColor
        }
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor:color)
            }
            else {
                return nil
            }
        }
    }
    
    
    @IBInspectable var shadowOpacity: Float {
        set {
            layer.shadowOpacity = newValue
        }
        get {
            return layer.shadowOpacity
        }
    }
    
    
    @IBInspectable var shadowOffset: CGPoint {
        set {
            layer.shadowOffset = CGSize(width: newValue.x, height: newValue.y)
        }
        get {
            return CGPoint(x: layer.shadowOffset.width, y:layer.shadowOffset.height)
        }
    }
    
    
    @IBInspectable var shadowRadius: CGFloat {
        set {
            layer.shadowRadius = newValue
        }
        get {
            return layer.shadowRadius
        }
    }
    
    
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            return nil
        }
    }
    
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
}


extension UIColor {
    struct vkColor {
        static let main = UIColor.init(red: 65/255, green: 107/255, blue: 158/255, alpha: 1)
    }
}

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * .pi / 180.0
    }
}


