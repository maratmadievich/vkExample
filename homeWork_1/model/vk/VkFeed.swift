//
//  VkNew.swift
//  homeWork_1
//
//  Created by Admin on 19.11.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit

class VkFeed {
    
    var sourceId = -1
    var sourceUrl = ""
    var sourceName = ""
    
    
    var feedId = -1
    var feedText = ""
    var feedDate = -1
    
    
    var attachments = [VkAttachment]()
    
    var countLikes = 0
    var countViews = 0
    var countReposts = 0
    var countComments = 0
    
    var isLiked = false
    
}

class VkAttachment { //only photo
    
    var imageUrl = ""
    var width = 0
    var height = 0
}
