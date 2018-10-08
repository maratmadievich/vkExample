//
//  News.swift
//  homeWork_1
//
//  Created by Марат Нургалиев on 30.09.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit

class New {
    var isLiked = false
    var likeCount = 0
    var text = ""
    
    
    func changeLike() {
        isLiked = !isLiked
        likeCount = likeCount + (isLiked ? 1:-1)
    }
}
