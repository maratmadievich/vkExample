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
    
    @IBOutlet weak var imageComment: UIImageView!
    
    @IBOutlet weak var imageNew: UIImageView!
    @IBOutlet weak var labelCountViews: UILabel!
    
    
    
    
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageAspectConstraint: NSLayoutConstraint!
    var delegate: NewsTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func prepareForReuse() {
        labelNews.text = ""
//        imageNew.image = UIImage(named: "newImage")
        
        imageAspectConstraint.priority = UILayoutPriority(rawValue: 1)
        imageHeightConstraint.priority = UILayoutPriority(rawValue: 1)

    }
    
    
    func loadData(new: New, needPhoto: Bool) {
        labelNews.text = new.text
        buttonLike.setupView(isLiked: new.isLiked, countLikes: new.likeCount)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        buttonLike.addGestureRecognizer(tap)
        if (needPhoto) {
            imageAspectConstraint.priority = UILayoutPriority(rawValue: 999)
            imageHeightConstraint.priority = UILayoutPriority(rawValue: 1)
        } else {
            imageAspectConstraint.priority = UILayoutPriority(rawValue: 1)
            imageHeightConstraint.priority = UILayoutPriority(rawValue: 999)
        }
        imageComment.tintColor = UIColor.lightGray
        setViews()
    }
    
    
    private func setViews() {
        var text = ""
        let viewCount = Int.random(in: 0..<2000000)
        print ("Mu random is : \(viewCount)")
        if viewCount > 1000000 {
            text = String(format: "%.2f М ", Float(viewCount)/1000000)
        } else if viewCount > 1000 {
            text = String(format: "%.2f К ", Float(viewCount)/1000)
        } else {
           text = "\(viewCount)"
        }
        labelCountViews.text = text
    }
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        buttonLike.changeLike()
        if let delegate = delegate {
            delegate.changeLike(row: buttonLike.tag)
        }
        
        
    }
    

}
