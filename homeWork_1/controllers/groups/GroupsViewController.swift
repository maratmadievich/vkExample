//
//  MyGroupsViewController.swift
//  homeWork_1
//
//  Created by Admin on 01.10.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit
import RealmSwift

class GroupsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var groups = [VkGroup]()
    
    //неюзаемая штука для показа возможностей
    private var results: Results<VkGroup>?
    private var notificationTokenGroups: NotificationToken?
    
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
        getMyGroups()
        setObserver()
    }
    
    
    private func setTableViewSettings() {
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    
    private func setSearchBarSettings() {
        searchBar.delegate = self
    }
    
    
    private func setObserver() {
        results = RealmWorker.instance.getItems(VkGroup.self)//RealmDatabase.get(VkGroup.self)//
        notificationTokenGroups = self.results?.observe { changes in
            print("groupObserver is work")
            switch changes {
            case .initial(let collection):
                print(collection)
            case .update(let collection, let deletions, let insertions, let modifications):
                print(collection)
                print(deletions)
                print(insertions)
                print(modifications)
            case .error(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
}

extension GroupsViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if searchActive {
            getMyGroups()
            searchActive = false
            groups.removeAll()
            tableView.reloadData()
            self.view.endEditing(true)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //Подумать над переделкой
        searchActive = (searchBar.text?.count)! > 0 ? true:false
        tableView.reloadData()
        self.view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        groups.removeAll()
        tableView.reloadData()
        if searchText == "" {
            searchActive = false
            getMyGroups()
        } else {
            searchActive = true
            getGroups(by: searchText)
        }
    }
}

extension GroupsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupCell", for: indexPath) as! MyGroupCell
        let group = groups[indexPath.row]
        cell.load(group)
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let row = editActionsForRowAt.row
        let isMember = groups[row].is_member > 0
        let leaveJoin = UITableViewRowAction(style: .normal, title: isMember ? "Покинуть":"Вступить") { action, index in
            let gid = self.groups[row].gid
            let name = self.groups[row].name
            self.groupSelected(gid: gid, name: name, isMember: isMember)
        }
        leaveJoin.backgroundColor = isMember ? .red : UIColor.vkColor.main
        return [leaveJoin]
    }
    
    func groupSelected(gid: Int, name: String, isMember: Bool) {
        let alert = UIAlertController(title: name, message: isMember ? "Вы действительно хотите покинуть группу?":"Вы действительно хотите вступить в эту группу?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: isMember ? "Покинуть":"Вступить", style: .default, handler: { action in
            isMember ? self.leaveGroup(by: gid) : self.joinGroup(by: gid)
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
}

//MARK: - Network funcs
extension GroupsViewController {
    
    private func getMyGroups() {
        AlamofireService.instance.getGroups(delegate: self)
    }
    
    private func getGroups(by search: String) {
        AlamofireService.instance.searchGroups(search: search, delegate: self)
    }
    
    private func leaveGroup(by gid: Int) {
        AlamofireService.instance.leaveGroup(gid: gid, delegate: self)
    }
    
    private func joinGroup(by gid: Int) {
        AlamofireService.instance.joinGroup(gid: gid, delegate: self)
    }
}

extension GroupsViewController: VkApiGroupsDelegate {
    
    func returnJoin(_ gid: Int) {
        for (index, group) in groups.enumerated() {
            if group.gid == gid {
                updateGroup(group: group, is_member: 1, index: index)
            }
        }
    }
    
    func returnJoin(_ error: String) {}
    
    func returnLeave(_ gid: Int) {
        for (index, group) in groups.enumerated() {
            if group.gid == gid {
                searchActive ?
                    updateGroup(group: group, is_member: 0, index: index) : deleteGroup(index: index)
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
            groups.remove(at: index)
            groups.insert(group, at: index)
            let indexPath = IndexPath(item: index, section: 0)
            tableView.reloadRows(at: [indexPath], with: is_member > 0 ?.right : .left)
        } catch {
            print("Realm saveFriends error: \(error)")
        }
    }
    
    
    private func deleteGroup(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        tableView.deleteRows(at: [indexPath], with: .top)
    }
    
    func returnLeave(_ error: String) {
        print("При попытке выйти из группы произошла ошибка: \(error)")
    }
    
    func returnGroups(_ groups: [VkGroup]) {
        self.groups.removeAll()
        self.groups = groups
        self.groups.sort { $0.name < $1.name}
        tableView.reloadData()
    }
    
}



