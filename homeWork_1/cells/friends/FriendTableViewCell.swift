//
//  FriendTableViewCell.swift
//  homeWork_1
//
//  Created by Марат Нургалиев on 30.09.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageAva: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadData(friend: Friend) {
        labelName.text = friend.lastName + " " + friend.firstName
        if let ava = friend.imageAva {
            imageAva.image = ava
        } else {
            imageAva.image = UIImage.init(named: "noPhoto")
        }
        
    }

}
