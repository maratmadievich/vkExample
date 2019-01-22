//
//  CommentTableViewCell.swift
//  homeWork_1
//
//  Created by Admin on 11/28/18.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageViewAva: UIImageView!
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelText: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func load(_ comment: VkComment) {
        labelName.text = comment.sender.getFullName()
        labelText.text = comment.text
        
        imageViewAva.sd_setImage(with: URL(string: comment.sender.imageUrl100), placeholderImage: UIImage(named: "noPhoto"))
    }

}
