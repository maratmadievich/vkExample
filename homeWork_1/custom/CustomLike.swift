//
//  CustomLike.swift
//  homeWork_1
//
//  Created by Марат Нургалиев on 30.09.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit

@IBDesignable class CustomLike: UIControl {
//    private var buttons: [UIButton] = []
    private var imageView = UIImageView()
    private var labelCount = UILabel()
    
    private var stackView: UIStackView!

    var countLikes = 0
    var isLiked = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
//    func setupView(isLiked: Bool, countLikes: Int) {
//
//        let button = UIButton(type: .system)
//        if countLikes > 0 {
//            button.setTitle("\(countLikes)", for: .normal)
//        }
//        button.setImage(UIImage.init(named: "like"), for: .normal)
//        button.isEnabled = false
//        if isLiked {
//            button.setTitleColor(.red, for: .normal)
//        } else {
//            button.setTitleColor(.lightGray, for: .normal)
//        }
//        self.buttons.append(button)
//        stackView = UIStackView(arrangedSubviews: self.buttons)
//        self.addSubview(stackView)
//
//        stackView.spacing = 8
//        stackView.axis = .horizontal
//        stackView.alignment = .center
//        stackView.distribution = .fillEqually
//    }
    func setupView(isLiked: Bool, countLikes: Int) {
        self.countLikes = countLikes
        self.isLiked = isLiked
        imageView.image = UIImage(named: "like")
        imageView.contentMode = .scaleAspectFit

        setColor()

        stackView = UIStackView(arrangedSubviews: [imageView, labelCount])
        self.addSubview(stackView)

        stackView.spacing = 2
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
    }
    
    
    private func setColor() {
//        if countLikes > 0 {
//            buttons[0].setTitle("\(countLikes)", for: .normal)
//        }
//        buttons[0].isEnabled = false
//        if isLiked {
//            buttons[0].setTitleColor(.red, for: .normal)
//        } else {
//            buttons[0].setTitleColor(.lightGray, for: .normal)
//        }
        if countLikes > 0 {
            labelCount.text = "\(countLikes)"
        } else {
             labelCount.text = ""
        }
        if isLiked {
            imageView.tintColor = UIColor.red
            labelCount.textColor = UIColor.red
        } else {
            imageView.tintColor = UIColor.lightGray
            labelCount.textColor = UIColor.lightGray
        }
    }
    
    
    func changeLike() {
        isLiked = !isLiked
        countLikes = countLikes + (isLiked ? 1:-1)
        setColor()
    }
}
