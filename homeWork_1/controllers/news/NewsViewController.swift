//
//  NewsViewController.swift
//  homeWork_1
//
//  Created by Марат Нургалиев on 30.09.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var news = [New]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableViewSettings()
        generateNews()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    private func setTableViewSettings() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    
    private func generateNews() {
        var i = 0
        while i < 20 {
            let new = New()
            new.isLiked = false
            new.likeCount = i
            new.text = "Новость №\(i)"
            news.append(new)
            i += 1
        }
    }

}


extension NewsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        cell.loadData(new: news[indexPath.row], needPhoto: indexPath.row % 2 > 0)
        cell.buttonLike.tag = indexPath.row
        cell.delegate = self
        return cell
    }

}

extension NewsViewController: NewsTableViewCellDelegate {
    func changeLike(row: Int) {
        news[row].changeLike()
    }
    
}




