//
//  FriendCollectionViewCell.swift
//  homeWork_1
//
//  Created by Марат Нургалиев on 30.09.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit

class FriendCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    func setImage(_ byUrl: String) {
        imageView.sd_setImage(with: URL(string: byUrl), placeholderImage: UIImage(named: "noPhoto"))
    }
    
}
