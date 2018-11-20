//
//  AllGroupsController.swift
//  homeWork_1
//
//  Created by Admin on 01.10.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit
import RealmSwift

class AllGroupsController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var searchedGroups = [VkGroup]()
    
    var searchActive = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.title = "Поиск группы"
        setTableViewSettings()
        setSearchBarSettings()
    }
    
    
    private func setTableViewSettings() {
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.reloadData()
    }
    
    
    private func setSearchBarSettings() {
        searchBar.delegate = self
    }
    
    
}

extension AllGroupsController: UISearchBarDelegate {
    
    //    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    //        searchActive = true;
    //    }
    //
    //    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    //        searchActive = false;
    //    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        searchedGroups.removeAll()
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
            searchedGroups.removeAll()
            tableView.reloadData()
        } else {
            searchActive = true
            AlamofireService.instance.searchGroups(search: searchText, delegate: self)
        }
        
        self.tableView.reloadData()
    }
}

extension AllGroupsController: UITableViewDelegate {}

extension AllGroupsController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupCell", for: indexPath) as! MyGroupCell
        cell.load(searchedGroups[indexPath.row])
        
        cell.delegate = self
        return cell
    }
}

extension AllGroupsController: GroupsProtocol {
    
    func groupSelected(gid: Int, name: String) {
        let groupIsMember = isMember(gid)
        let alert = UIAlertController(title: name, message: groupIsMember ? "Вы действительно хотите покинуть группу?":"Вы действительно хотите вступить в эту группу?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: groupIsMember ? "Покинуть":"Вступить", style: .default, handler: { action in
            groupIsMember ? AlamofireService.instance.leaveGroup(gid: gid, delegate: self) :
            AlamofireService.instance.joinGroup(gid: gid, delegate: self)
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    private func isMember(_ gid: Int) -> Bool {
        for group in searchedGroups {
            if group.gid == gid {
                return group.is_member > 0
            }
        }
        return false
    }
    
    
}

extension AllGroupsController: VkApiGroupsDelegate {
    
    func returnJoin(_ gid: Int) {
        for (index, group) in searchedGroups.enumerated() {
            if group.gid == gid {
                updateGroup(group: group, is_member: 1, index: index)
            }
        }
    }
    
    func returnJoin(_ error: String) {
        
        print("При попытке вступить в группу произошла ошибка: \(error)")
    }
    
    
    func returnGroups(_ groups: [VkGroup]) {
        self.searchedGroups.removeAll()
        self.searchedGroups = groups
        self.searchedGroups.sort { $0.name < $1.name}
        tableView.reloadData()
    }
    
    func returnLeave(_ gid: Int) {
        for (index, group) in searchedGroups.enumerated() {
            if group.gid == gid {
                updateGroup(group: group, is_member: 0, index: index)
            }
        }
    }
    
    
    private func updateGroup(group: VkGroup, is_member: Int, index: Int) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            group.is_member = is_member
            realm.add(group, update: true)
            try realm.commitWrite()
            searchedGroups.remove(at: index)
            searchedGroups.insert(group, at: index)
            let indexPath = IndexPath(item: index, section: 0)
            tableView.reloadRows(at: [indexPath], with: is_member > 0 ?.right : .left)
        } catch {
            print("Realm saveFriends error: \(error)")
        }
    }
    
    func returnLeave(_ error: String) {}
    
}

