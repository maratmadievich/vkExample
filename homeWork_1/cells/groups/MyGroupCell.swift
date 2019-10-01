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
    @IBOutlet weak var labelMember: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
    }
	
	func configure(with presenter: GroupCellPresenterProtocol) {
		labelName.text = presenter.getNameTitle()
		labelType.text = presenter.getTypeTitle()
		labelMember.text = presenter.getMemberTitle()
		imageAva.sd_setImage(with: presenter.getImageUrl(), placeholderImage: presenter.getImagePlaceholder())
	}

}
