//
//  CustomSquareIndicator.swift
//  homeWork_1
//
//  Created by Admin on 15.10.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit

class CustomSquareIndicator: UIActivityIndicatorView {
    //Для того, чтобы сделать квадрат
    private var mainView = UIView()
    
    
    
    override func draw(_ rect: CGRect) {
//        if (self.frame.width > self.frame.height) {
//            mainView.frame = CGRect(x: (self.frame.width - self.frame.height) / 1.2, y: 0, width: self.frame.height, height: self.frame.height)
//        } else {
//            mainView.frame = CGRect(x: 0, y: (self.frame.height - self.frame.width) / 1.2, width: self.frame.width, height: self.frame.width)
//        }
//        mainView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
//        mainView.cornerRadius = 5//mainView.frame.width/2
        
        

        
    }
    
    override func startAnimating() {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setStrokeColor(UIColor.red.cgColor)
        context.move(to: CGPoint(x: 40, y: 20))
        context.addLine(to: CGPoint(x: 45, y: 40))
        context.addLine(to: CGPoint(x: 65, y: 40))
        context.addLine(to: CGPoint(x: 50, y: 50))
        context.addLine(to: CGPoint(x: 60, y: 70))
        context.addLine(to: CGPoint(x: 40, y: 55))
        context.addLine(to: CGPoint(x: 20, y: 70))
        context.addLine(to: CGPoint(x: 30, y: 50))
        context.addLine(to: CGPoint(x: 15, y: 40))
        context.addLine(to: CGPoint(x: 35, y: 40))
        context.closePath()
        context.strokePath()
        
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.fromValue = 0
        strokeStartAnimation.toValue = 1
        
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = 0
        strokeEndAnimation.toValue = 1.2
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 2
        animationGroup.animations = [strokeStartAnimation, strokeEndAnimation]
        
        
    }
}
