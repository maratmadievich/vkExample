//
//  MyGroupsViewController.swift
//  homeWork_1
//
//  Created by Admin on 01.10.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol GroupsProtocol {
    
    func groupSelected(row: Int)
}

class MyGroupsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var selectedRow = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Группы"
        setTableViewSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.tableView.reloadData()
    }
    
    
    private func setTableViewSettings() {
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    
    @IBAction func btnAddGroupClicked(_ sender: Any) {
        performSegue(withIdentifier: "showUnjoinedGroups", sender: nil)
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
    
}

extension MyGroupsViewController: UITableViewDelegate {}

extension MyGroupsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GlobalConstants.groupList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupCell", for: indexPath) as! MyGroupCell
        cell.labelName.text = GlobalConstants.getGroupName(value: GlobalConstants.groupList[indexPath.row])
        cell.labelType.text = GlobalConstants.getGroupType(value: GlobalConstants.groupList[indexPath.row])
        cell.btnGroup.tag = indexPath.row
        cell.delegate = self
        return cell
    }
    
}

extension MyGroupsViewController: GroupsProtocol {
    
    func groupSelected(row: Int) {
        let alert = UIAlertController(title: GlobalConstants.getGroupName(value: GlobalConstants.groupList[row]), message: "Вы действительно хотите покинуть группу?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Покинуть", style: .destructive, handler: { action in
            GlobalConstants.groupList.remove(at: row)
            GlobalConstants.saveGroups()
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
}



