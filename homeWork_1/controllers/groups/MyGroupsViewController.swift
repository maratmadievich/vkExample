//
//  MyGroupsViewController.swift
//  homeWork_1
//
//  Created by Admin on 01.10.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol GroupsProtocol {
    
    func groupSelected(gid: Int, name: String)
}

class MyGroupsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var myGroups = [VkGroup]()
    private var filteredGroups = [VkGroup]()
    
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
//        setMyGroups()
        AlamofireService.instance.getGroups(delegate: self)
    }
    
    
//    private func setMyGroups() {
//        myGroups.removeAll()
//        filteredGroups.removeAll()
//        for value in GlobalConstants.groupList {
//            let group = Group()
//            group.value = value
//            group.name = GlobalConstants.getGroupName(value: value)
//            group.type = GlobalConstants.getGroupType(value: value)
//            myGroups.append(group)
//        }
//        tableView.reloadData()
//    }
    
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
        cell.delegate = self
        cell.load(group)
        return cell
    }
    
}

extension MyGroupsViewController: GroupsProtocol {
    
    func groupSelected(gid: Int, name: String) {
        let alert = UIAlertController(title: name, message: "Вы действительно хотите покинуть группу?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Покинуть", style: .destructive, handler: { action in
            AlamofireService.instance.leaveGroup(gid: gid, delegate: self)
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    func removeRowBy(gid: Int) {
        for (index, group) in filteredGroups.enumerated() {
            if gid == group.gid {
                filteredGroups.remove(at: index)
                if searchActive {
                    let indexPath = IndexPath(item: index, section: 0)
                    tableView.deleteRows(at: [indexPath], with: .middle)
                }
                break
            }
            
        }
        for (index, group) in myGroups.enumerated() {
            if gid == group.gid {
                myGroups.remove(at: index)
                if !searchActive {
                    let indexPath = IndexPath(item: index, section: 0)
                    tableView.deleteRows(at: [indexPath], with: .middle)
                }
                break
            }
        }
        
        tableView.reloadData()
    }
    
}

extension MyGroupsViewController: VkApiGroupsDelegate {
    
    func returnJoin(_ gid: Int) {}
    
    func returnJoin(_ error: String) {}
    
    func returnLeave(_ gid: Int) {
        removeRowBy(gid: gid)
    }
    
    func returnLeave(_ error: String) {
        print("При попытке выйти из группы произошла ошибка: \(error)")
    }
    
    func returnGroups(_ groups: [VkGroup]) {
        self.myGroups.removeAll()
        self.myGroups = groups
        self.myGroups.sort { $0.name < $1.name}
        tableView.reloadData()
    }
    
}



