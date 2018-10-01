//
//  NewsTableViewCell.swift
//  homeWork_1
//
//  Created by Марат Нургалиев on 30.09.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol NewsTableViewCellDelegate {
    func changeLike(row: Int)
}

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelNews: UILabel!
    @IBOutlet weak var buttonLike: CustomLike!
    
    var delegate: NewsTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func loadData(new: New) {
        labelNews.text = new.text
        buttonLike.setupView(isLiked: new.isLiked, countLikes: new.likeCount)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
       buttonLike.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        buttonLike.changeLike()
        if let delegate = delegate {
            delegate.changeLike(row: buttonLike.tag)
        }
        
        
    }
    

}
