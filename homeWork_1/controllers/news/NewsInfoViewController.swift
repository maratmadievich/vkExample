//
//  NewsInfoViewController.swift
//  homeWork_1
//
//  Created by Admin on 11/28/18.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit

class NewsInfoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

	private let networkAdapter = NetworkAdapterFactory().makeAdapter()
	private let cellPresenterFactory = CellPresenterFactory()
	
    var feed = VkFeed()
    var comments = [VkComment]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewSettings()
        prepareGetComments()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    private func setTableViewSettings() {
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    private func prepareGetComments() {
        networkAdapter.getComments(ownerId: feed.sourceId, postId: feed.feedId, delegate: self)
    }
    

}

extension NewsInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsInfoTableViewCell", for: indexPath) as! NewsInfoTableViewCell
			let cellPresenter = cellPresenterFactory.makeFeedCellPresenter(feed: feed)
			cell.configure(with: cellPresenter)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as! CommentTableViewCell
			let cellPresenter = cellPresenterFactory.makeCommentCellPresenter(commnent: comments[indexPath.row])
				cell.configure(with: cellPresenter)
            return cell
        }
    }
    
}

//MARK: - Make cellPresenter
extension NewsInfoViewController {
	
	
}

extension NewsInfoViewController: VkApiCommentsDelegate {
    
    func returnComments(_ comments: [VkComment]) {
        self.comments.removeAll()
        self.comments.append(contentsOf: comments)
        tableView.reloadData()
    }
}
