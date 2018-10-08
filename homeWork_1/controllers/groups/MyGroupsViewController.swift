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
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var myGroups = [Group]()
    private var filteredGroups = [Group]()
    
    var searchActive = false
    
    var selectedRow = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Группы"
        setTableViewSettings()
        setSearchBarSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        setMyGroups()
        self.tableView.reloadData()
    }
    
    
    private func setMyGroups() {
        myGroups.removeAll()
        filteredGroups.removeAll()
        for value in GlobalConstants.groupList {
            let group = Group()
            group.value = value
            group.name = GlobalConstants.getGroupName(value: value)
            group.type = GlobalConstants.getGroupType(value: value)
            myGroups.append(group)
        }
        tableView.reloadData()
    }
    
    private func setTableViewSettings() {
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    
    private func setSearchBarSettings() {
        searchBar.delegate = self
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

extension MyGroupsViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        tableView.reloadData()
        self.view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = (searchBar.text?.count)! > 0 ? true:false
        tableView.reloadData()
        self.view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            searchActive = false
        } else {
            searchActive = true
            filteredGroups.removeAll()
            filteredGroups = myGroups.filter{$0.name.lowercased().contains(searchText.lowercased())}
        }
        
        self.tableView.reloadData()
    }
}

extension MyGroupsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchActive ? filteredGroups.count: myGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupCell", for: indexPath) as! MyGroupCell
        let group = searchActive ? filteredGroups[indexPath.row]: myGroups[indexPath.row] 
        
        cell.labelName.text = group.name
        cell.labelType.text = group.type
        cell.btnGroup.tag = group.value
        cell.delegate = self
        return cell
    }
    
}

extension MyGroupsViewController: GroupsProtocol {
    
    func groupSelected(row: Int) {
        let alert = UIAlertController(title: GlobalConstants.getGroupName(value: GlobalConstants.groupList[row]), message: "Вы действительно хотите покинуть группу?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Покинуть", style: .destructive, handler: { action in
            self.removeRowBy(value: row)
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    func removeRowBy(value: Int) {
        for (index, group) in filteredGroups.enumerated() {
            if value == group.value {
                filteredGroups.remove(at: index)
                break
            }
        }
        for (index, group) in myGroups.enumerated() {
            if value == group.value {
                myGroups.remove(at: index)
                break
            }
        }
        for (index, group) in GlobalConstants.groupList.enumerated() {
            if value == group {
                GlobalConstants.groupList.remove(at: index)
                break
            }
        }
        GlobalConstants.saveGroups()
    }
    
}



