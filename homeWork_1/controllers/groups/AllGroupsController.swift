//
//  AllGroupsController.swift
//  homeWork_1
//
//  Created by Admin on 01.10.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit

class AllGroupsController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    struct Group {
        var name = String()
        var value = Int()
    }
    
    var realAllGroups = [Group]()
    var filteredGroups = [Group]()
    
    var searchActive = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.title = "Все группы"
        setUnjoinedGroups()
        setTableViewSettings()
        setSearchBarSettings()
    }
    
    
    private func setUnjoinedGroups() {
        var i = 0
        while i < 30 {
            var needAdd = true
            for number in GlobalConstants.groupList {
                if i == number {
                    needAdd = false
                    break
                }
            }
            if needAdd {
                var group = Group()
                group.value = i
                group.name = GlobalConstants.getGroupName(value: i)
                realAllGroups.append(group)
            }
            i += 1
        }
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
            filteredGroups = realAllGroups.filter{$0.name.lowercased().contains(searchText.lowercased())}
        }
        
        self.tableView.reloadData()
    }
}

extension AllGroupsController: UITableViewDelegate {}

extension AllGroupsController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchActive ? filteredGroups.count : realAllGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupCell", for: indexPath) as! MyGroupCell
        
        let group = searchActive ? filteredGroups[indexPath.row] : realAllGroups[indexPath.row]
        cell.labelName.text = group.name
        cell.labelType.text =  GlobalConstants.getGroupType(value: group.value)
        cell.btnGroup.tag = indexPath.row
        cell.btnGroup.setTitle("Вступить", for: .normal)
        cell.delegate = self
        return cell
    }
}

extension AllGroupsController: GroupsProtocol {
    
    func groupSelected(row: Int) {
        let group = searchActive ? filteredGroups[row]:realAllGroups[row]
        let alert = UIAlertController(title: group.name, message: "Вы действительно хотите вступить в эту группу?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Вступить", style: .default, handler: { action in
            GlobalConstants.groupList.append(group.value)
            GlobalConstants.saveGroups()
            self.remove(group: group)
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    private func remove(group: Group) {
        var i = 0
        while i < (realAllGroups.count) {
            if realAllGroups[i].value == group.value {
                realAllGroups.remove(at: i)
                break
            }
            i += 1
        }
        
        if searchActive {
            i = 0
            while i < (filteredGroups.count) {
                if filteredGroups[i].value == group.value {
                    filteredGroups.remove(at: i)
                    break
                }
                i += 1
            }
        }
    }
    
}

