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
    private let refreshControl = UIRefreshControl()
    
    
    private var feeds = [VkFeed]()
    
    var startFrom = ""
    private var needClearNews = true
    private var isLoad = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setObserver()
        setTableViewSettings()
        prepareGetFeeds(needClearNews: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    
    private func setObserver() {
        let nextFromNotification = Notification.Name("nextFromNotification")
        NotificationCenter.default.addObserver(self, selector: #selector(updateNextFrom(notification:)), name: nextFromNotification, object: nil)
    }
    
    
    @objc func updateNextFrom(notification: Notification) {
        if let nextFrom = notification.userInfo?["nextFrom"] as? String {
            self.startFrom = nextFrom
        }
    }
    
    
    private func prepareGetFeeds(needClearNews: Bool) {
        isLoad = true
        self.needClearNews = needClearNews
        AlamofireService.instance.getNews(startFrom: needClearNews ? "":startFrom, delegate: self)
    }
    
    
    private func setTableViewSettings() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshNews(_:)), for: .valueChanged)
    }
    
    
    @objc private func refreshNews(_ sender: Any) {
        prepareGetFeeds(needClearNews: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFeedInfo" {
            let upcoming = segue.destination as! NewsInfoViewController
            upcoming.feed = feeds[sender as! Int]
        }
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }

}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        cell.load(feed: feeds[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showFeedInfo", sender: indexPath.row)
    }
    
    
    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == feeds.count - 2 && !isLoad {
            
            prepareGetFeeds(needClearNews: false)
        }
    }

}

extension NewsViewController: NewsTableViewCellDelegate {
    func changeLike(row: Int) {
//        news[row].changeLike()
    }
    
}

extension NewsViewController: VkApiFeedsDelegate {
    
    func returnFeeds(_ feeds: [VkFeed]) {
//        DispatchQueue.main.async {
//            self.refreshControl.endRefreshing()
//            self.isLoad = false
//            if self.needClearNews {
//                self.feeds.removeAll()
//                self.tableView.reloadData()
//            }
//            self.feeds.append(contentsOf: feeds)
//            self.tableView.reloadData()
//        }
        self.refreshControl.endRefreshing()
        isLoad = false
        if needClearNews {
            self.feeds.removeAll()
            tableView.reloadData()
        }
        self.feeds.append(contentsOf: feeds)
        tableView.reloadData()
        //        self.addNewCells(array: feeds)

    }
    
    
    private func addNewCells(array: [VkFeed]) {
        if (array.count > 0) {
            tableView.beginUpdates()
            var indexPaths = [NSIndexPath]()
            for row in (feeds.count..<(feeds.count + array.count)) {
                indexPaths.append(NSIndexPath(row: row, section: 0))
            }
            feeds.append(contentsOf: array)
            
            tableView.insertRows(at: indexPaths as [IndexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
}




