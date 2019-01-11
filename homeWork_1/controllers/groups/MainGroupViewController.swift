//
//  MainGroupViewController.swift
//  homeWork_1
//
//  Created by Admin on 12/5/18.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit

class MainGroupViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var containerGroups: UIView!
    
    private var currentSegment = 0
    
    private lazy var myGroupsViewController: GroupsViewController = {
        let vc = GroupsViewController()
        self.add(childViewController: vc)
        return vc
    }()

    private lazy var searchGroupsViewController: SearchGroupViewController = {
        let vc = SearchGroupViewController()
        self.add(childViewController: vc)
        return vc
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setSegmentedControlSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    private func setSegmentedControlSettings() {
        segmentedControl.backgroundColor = UIColor.vkColor.main
        
        segmentedControl.tintColor = .clear
        
        segmentedControl.setTitleTextAttributes([
            NSAttributedStringKey.font : UIFont(name: "HelveticaNeue", size: 17),
            NSAttributedStringKey.foregroundColor: UIColor.lightGray
            ], for: .normal)
        
        segmentedControl.setTitleTextAttributes([
            NSAttributedStringKey.font : UIFont(name: "HelveticaNeue-Medium", size: 17),
            NSAttributedStringKey.foregroundColor: UIColor.white
            ], for: .selected)
        
    }
    
    
    
    @IBAction func segmentControlDidChanged(_ sender: Any) {
        if currentSegment != segmentedControl.selectedSegmentIndex {
            currentSegment = segmentedControl.selectedSegmentIndex
            
            switch segmentedControl.selectedSegmentIndex
            {
            case 0:
                add(childViewController: myGroupsViewController)
            case 1:
                add(childViewController: searchGroupsViewController)
            default:
                break;
            }
        }
    }
    
    

    
    

}

//MARK: - Work with ContainerView

extension MainGroupViewController {
    
    func add(childViewController: UIViewController) {
//        addChildViewController(childVC)
        for view in containerGroups.subviews {
            view.removeFromSuperview()
        }
        containerGroups.addSubview(childViewController.view)
        childViewController.view.frame = self.view.frame
        childViewController.didMove(toParentViewController: self)
    }
    
}
