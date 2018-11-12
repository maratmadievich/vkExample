//
//  FriendTableViewCell.swift
//  homeWork_1
//
//  Created by Марат Нургалиев on 30.09.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit
import SDWebImage

class FriendTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageAva: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadData(friend: VkFriend) {
        labelName.text = friend.last_name + " " + friend.first_name
        if friend.photo.count > 0 {
            imageAva.sd_setImage(with: URL(string: friend.photo), placeholderImage: UIImage(named: "noPhoto"))
        }
//        if friend.
//        if let ava = friend.imageAva {
//            imageAva.image = ava
//        } else {
//            imageAva.image = UIImage.init(named: "noPhoto")
//        }
        
    }

}
