//
//  MyGroupCell.swift
//  homeWork_1
//
//  Created by Admin on 01.10.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit

class MyGroupCell: UITableViewCell {

    @IBOutlet weak var imageAva: UIImageView!
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelType: UILabel!
    
    @IBOutlet weak var btnGroup: UIButton!
    
    var delegate: GroupsProtocol? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func btnGroupClicked(_ sender: Any) {
        delegate?.groupSelected(row: btnGroup.tag)
    }

}
