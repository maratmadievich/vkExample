//
//  ImagesViewController.swift
//  homeWork_1
//
//  Created by Admin on 15.10.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit

class ImagesViewController: UIViewController {
    
    var interactiveAnimator: UIViewPropertyAnimator!
    
    let viewContaiter = UIView()
    
    var bySwipe = false
    
    var curImageView = UIView()
    var curImageFrame = CGRect()
    var images = [UIImage]()
    
    
    var selectedImage = 0
    var previousImage = 0
    
    var width: CGFloat = 0
    var height: CGFloat = 0
    
    var xStart: CGFloat = 0
    var xA: CGFloat = 0
    var xB: CGFloat = 0

    private var offsetValue: CGFloat = 60
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImageViews()
        setStartImage()
        setSwipeGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor.black
    }

    
    private func setImageViews() {
        width = self.view.frame.width
        height = self.view.frame.height
        
        viewContaiter.frame = CGRect(x: 0, y: 0, width: width * CGFloat(images.count), height: height)
        
        for (i, image) in images.enumerated() {
            let imageView = UIImageView()
            imageView.frame = CGRect(x: width * CGFloat(i), y: 0, width: width, height: height)
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            imageView.tag = i
            viewContaiter.addSubview(imageView)
        }
        self.view.addSubview(viewContaiter)
    }
    
    
    private func setStartImage() {
        UIView.animate(withDuration: 0, delay: 0, options: [], animations: {
            self.viewContaiter.frame.origin.x = -(self.width * CGFloat(self.selectedImage))
        })
    }
    
    
    private func setCurrentImage(_ duration: TimeInterval) {
        self.title = "Фото \(selectedImage + 1)/\(images.count)"

        var previousView = UIView()
        var previousFrame = CGRect()
        for view in viewContaiter.subviews {
            if view.tag == previousImage {
                previousView = view
                previousFrame = view.frame
                break
            }
        }
        UIView.animateKeyframes(withDuration: 0.5,
                                delay: 0,
                                options: [],
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0,
                                                       relativeDuration: 0.1,
                                                       animations: {
                                                        previousView.frame = CGRect(x: previousFrame.origin.x + self.offsetValue, y: previousFrame.origin.y + self.offsetValue, width: previousFrame.width - self.offsetValue * 2, height: previousFrame.height - self.offsetValue * 2)
                                                        
                                    })
                                    UIView.addKeyframe(withRelativeStartTime: 0,
                                                       relativeDuration: 0.5,
                                                       animations: {
                                                        self.viewContaiter.frame.origin.x = -(self.width * CGFloat(self.selectedImage))
                                    })
                                    UIView.addKeyframe(withRelativeStartTime: 0.5,
                                                       relativeDuration: 0,
                                                       animations: {
                                                        previousView.frame = previousFrame
                                    })
        },
                                completion: nil)
    }
    
    
    private func setSwipeGesture() {
        self.title = "Фото \(selectedImage + 1)/\(images.count)"
        if (bySwipe) {
            let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
            swipeLeft.direction = .left
            self.view.addGestureRecognizer(swipeLeft)
            
            let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
            swipeRight.direction = .right
            self.view.addGestureRecognizer(swipeRight)
        } else {
            let recognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
            self.view.addGestureRecognizer(recognizer)
        }
    }

    
    // Свайпами
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        var needAnimate = false
        if gesture.direction == UISwipeGestureRecognizerDirection.right {
            if (selectedImage - 1 >= 0) {
                previousImage = selectedImage
                selectedImage -= 1
                needAnimate = true
            }
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.left {
            if (selectedImage + 1 < images.count) {
                previousImage = selectedImage
                selectedImage += 1
                needAnimate = true
            }
        }
        if needAnimate {
            self.setCurrentImage(0.1)
        }
    }
    
    
    // Интерактивно
    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            for view in viewContaiter.subviews {
                if view.tag == selectedImage {
                    curImageView = view
                    curImageFrame = view.frame
                }
            }
            xStart = recognizer.location(in: self.view).x
            print ("xStart = \(xStart)")
            xA = xStart
            break
            
        case .changed:
            print ("xA = \(xA)")
            xB = recognizer.location(in: self.view).x
            print ("xB = \(xB)")
            let xDifference = abs(xB - xStart) * 3 / width
            UIView.animate(withDuration: 0.05, delay: 0, options: [.curveEaseOut], animations: {
                self.viewContaiter.frame = self.viewContaiter.frame.offsetBy(dx: (self.xB - self.xA), dy: 0)
                self.curImageView.frame = CGRect(x: self.curImageFrame.origin.x + (self.offsetValue * xDifference), y: self.curImageFrame.origin.y + (self.offsetValue * xDifference), width: self.curImageFrame.width - (self.offsetValue * 2 * xDifference), height: self.curImageFrame.height - (self.offsetValue * 2 * xDifference))
            },  completion: { _ in
                self.xA = self.xB
            })
            break
            
        case .ended:
            xB = recognizer.location(in: self.view).x
            print ("Move difference: \(xB - xStart)")
            let isLeft = (xB - xStart > 0)
            let needMove = abs(xB - xStart) > (width / 4)
            if (needMove) {
                if isLeft {
                    if (selectedImage - 1 >= 0) {
                        previousImage = selectedImage
                        selectedImage -= 1
                    }
                } else {
                    if (selectedImage + 1 < images.count) {
                        previousImage = selectedImage
                        selectedImage += 1
                    }
                }
            }
            setSimpleAnimation(0.1)
            break
            
        default: return
        }
    }
    
    
    private func setSimpleAnimation(_ duration: TimeInterval) {
        self.title = "Фото \(selectedImage + 1)/\(images.count)"
        UIView.animateKeyframes(withDuration: 0.35,
                                delay: 0,
                                options: [],
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0,
                                                       relativeDuration: 0.25,
                                                       animations: {
                                                        self.viewContaiter.frame.origin.x = -(self.width * CGFloat(self.selectedImage))
                                    })
                                    UIView.addKeyframe(withRelativeStartTime: 0.25,
                                                       relativeDuration: 0.1,
                                                       animations: {
                                                        self.curImageView.frame = self.curImageFrame
                                    })
        })
    }
    

}
