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
    
    private var selectedImage = 0
    var bySwipe = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionViewSettings()
        parseFriend()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor.vkColor.main
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

extension FriendInfoViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showImages") {
            let upcoming: ImagesViewController = segue.destination as! ImagesViewController
            upcoming.selectedImage = selectedImage
            upcoming.images = friend.images
            upcoming.bySwipe = bySwipe
        }
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
    private func showSwipeAlert() {
        let alert = UIAlertController(title: "Как хотите управлять изображениями?", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Свайпами", style: .default, handler: { action in
            self.bySwipe = true
            self.performSegue(withIdentifier: "showImages", sender: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Интерактивно", style: .default, handler: { action in
            self.bySwipe = false
            self.performSegue(withIdentifier: "showImages", sender: nil)
        }))
        
        self.present(alert, animated: true)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedImage = indexPath.row
        collectionView.deselectItem(at: indexPath, animated: true)
        showSwipeAlert()
    }
    
}
