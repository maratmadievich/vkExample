//
//  MyGroupCell.swift
//  homeWork_1
//
//  Created by Admin on 01.10.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit
import SDWebImage

class MyGroupCell: UITableViewCell {

    @IBOutlet weak var imageAva: UIImageView!
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelType: UILabel!
    
    @IBOutlet weak var btnGroup: UIButton!
    
    var delegate: GroupsProtocol? = nil
    var group: VkGroup!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func load(_ group: VkGroup) {
        self.group = group
        labelName.text = group.name
        labelType.text = group.type
        btnGroup.tag = group.gid
        
        if group.photo.count > 0 {
            imageAva.sd_setImage(with: URL(string: group.photo), placeholderImage: UIImage(named: "noPhoto"))
        }
        if group.is_member > 0 {
            btnGroup.setTitle("Покинуть", for: .normal)
        } else {
            btnGroup.setTitle("Вступить", for: .normal)
        }
        
    }
    
    @IBAction func btnGroupClicked(_ sender: Any) {
        delegate?.groupSelected(gid: group.gid, name: group.name)
    }

}
