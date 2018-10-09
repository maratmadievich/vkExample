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
       
        if (needPhoto) {
            imageAspectConstraint.priority = UILayoutPriority(rawValue: 999)
            imageHeightConstraint.priority = UILayoutPriority(rawValue: 1)
        } else {
            imageAspectConstraint.priority = UILayoutPriority(rawValue: 1)
            imageHeightConstraint.priority = UILayoutPriority(rawValue: 999)
        }
        imageComment.tintColor = UIColor.lightGray
        setViews()
        setTaps()
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
    
    private func setTaps() {
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(_:)))
        imageNew.addGestureRecognizer(imageTap)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.likeTapped(_:)))
        buttonLike.addGestureRecognizer(tap)
    }
    
    
    @objc func likeTapped(_ sender: UITapGestureRecognizer) {
        buttonLike.changeLike()
        if let delegate = delegate {
            delegate.changeLike(row: buttonLike.tag)
        }
    }
    
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        let imageWidth = imageNew.frame.width
        let scale = imageWidth * 0.6
        let originY = imageNew.frame.origin.y
        
        UIView.animate(withDuration: 0.5, animations: {
            self.imageNew.bounds = CGRect(x: scale / 2 , y: originY + scale / 2, width: scale, height: scale)
        }, completion: { _ in
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0.7,
                           options: [],
                           animations: {
                            self.imageNew.bounds = CGRect(x: 0, y: originY, width: imageWidth, height: imageWidth)
            })
        })
        
        
    }
    

}
