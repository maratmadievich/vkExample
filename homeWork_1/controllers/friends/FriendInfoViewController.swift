//
//  FriendInfoViewController.swift
//  homeWork_1
//
//  Created by Марат Нургалиев on 30.09.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit

class FriendInfoViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var friend = Friend()

    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionViewSettings()
        parseFriend()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    private func setCollectionViewSettings() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    private func parseFriend() {
        self.navigationItem.title = friend.lastName + " " + friend.firstName
        self.collectionView.reloadData()
    }

}

extension FriendInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friend.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendCollectionViewCell", for: indexPath) as! FriendCollectionViewCell
        cell.imageView.image = friend.images[indexPath.row]
        return cell
    }
    
    
}
