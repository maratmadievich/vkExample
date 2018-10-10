//
//  FriendsViewController.swift
//  homeWork_1
//
//  Created by Марат Нургалиев on 30.09.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol FriendsViewControllerDelegate {
    
    func selectTitle(title: String)
}

class FriendsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var customControll: CustomControl!
    
    @IBOutlet weak var searchBar: CustomSearchBar!
    
    
    var searchActive = false
    
    private var selectedSection = -1
    private var selectedRow = -1
    
    private var friends = [Friend]()
    private var groupedFriends = [FriendList]()
    private var filteredGroupedFriends = [FriendList]()
    
    private var lastNames = ["Иванов",
                             "Петров",
                             "Сидоров",
                             "Алтунин",
                             "Железнов",
                             "Васильев",
                             "Гребенщиков",
                             "Кинчев",
                             "Цой",
                             "Сюткин",
                             "Шевчук",
                             "Шахрин"]
    
    private var firstNames = ["Александр",
                              "Алексей",
                              "Евгений",
                              "Максим",
                              "Владимир",
                              "Виктор",
                              "Руслан",
                              "Дмитрий",
                              "Валерий"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewSettings()
        setFriends()
        setCustomView()
        setSearchBarSettings()
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
    
    
    private func setFriends() {
        var i = 0
        while i < 30 {
            let friend = Friend()
            friend.firstName = firstNames[i % firstNames.count]
            friend.lastName = lastNames[i % lastNames.count]
            friend.imageAva = returnFriendImage(i: i)
            friend.images = returnAllImages(row: i)
            friends.append(friend)
            i += 1
        }
        friends.sort { ($0.lastName, $0.firstName) <
            ($1.lastName, $1.firstName)}
        setGroupedFriend()
    }
    
    
    private func setGroupedFriend() {
        GlobalConstants.titles.removeAll()
        var groupedFriend = FriendList()
        for friend in friends {
            print ("\(friend.lastName) \(friend.firstName)")
            if groupedFriend.title != friend.lastName.prefix(1) {
                GlobalConstants.titles.append(String(friend.lastName.prefix(1)))
                if (groupedFriend.title.count != 0) {
                    groupedFriends.append(groupedFriend)
                    groupedFriend = FriendList()
                }
                groupedFriend.title = String(friend.lastName.prefix(1))
            }
            groupedFriend.friends.append(friend)
        }
        groupedFriends.append(groupedFriend)
    }
    
    
    private func setCustomView() {
        customControll.delegate = self
        customControll.setupView()
    }
    
    
    private func setSearchBarSettings() {
        searchBar.delegate = self
        searchBar.setSubViews(width: self.view.frame.width)
    }
    
    
    private func returnFriendImage(i: Int) -> UIImage? {
        let value = i % 3
        switch value {
        case 0:
            return UIImage.init(named: "woman")
        case 1:
            return UIImage.init(named: "man")
        default:
            return nil
        }
    }
    
    private func returnAllImages(row: Int) -> [UIImage] {
        var images = [UIImage]()
        var i = 0
        
        let value = row % 3
        switch value {
        case 0:
            repeat {
                images.append(UIImage.init(named: "woman")!)
                i += 1
            } while i < row
            break
            
        case 1:
            repeat {
                images.append(UIImage.init(named: "man")!)
                i += 1
            } while i < row
            break
            
        default:
            images.append(UIImage.init(named: "noPhoto")!)
        }
        return images
    }
    

}

extension FriendsViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showFriend") {
            let upcoming:FriendInfoViewController = segue.destination as! FriendInfoViewController
            upcoming.friend = searchActive ? filteredGroupedFriends[selectedSection].friends[selectedRow] : groupedFriends[selectedSection].friends[selectedRow]
        }
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
}

extension FriendsViewController: CustomSearchBarDelegate {
    
    func textChanged(text: String) {
        if text == "" {
            searchActive = false
        } else {
            searchActive = true
            filteredGroupedFriends.removeAll()
            for group in groupedFriends {
                let filteredFriends = group.friends.filter{$0.firstName.lowercased().contains(text.lowercased()) || $0.lastName.lowercased().contains(text.lowercased())}
                if filteredFriends.count > 0 {
                    let filterGroup = FriendList()
                    filterGroup.title = group.title
                    filterGroup.friends = filteredFriends
                    filteredGroupedFriends.append(filterGroup)
                }
            }
        }
        
        self.tableView.reloadData()
    }
    
    func cancelSearch() {
        searchActive = false
        tableView.reloadData()
        self.view.endEditing(true)
    }
    
    
}

//extension FriendsViewController: UISearchBarDelegate {
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchActive = false
//        tableView.reloadData()
//        self.view.endEditing(true)
//    }
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        searchActive = (searchBar.text?.count)! > 0 ? true:false
//        tableView.reloadData()
//        self.view.endEditing(true)
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText == "" {
//            searchActive = false
//        } else {
//            searchActive = true
//            filteredGroupedFriends.removeAll()
//            for group in groupedFriends {
//                let filteredFriends = group.friends.filter{$0.firstName.lowercased().contains(searchText.lowercased()) || $0.lastName.lowercased().contains(searchText.lowercased())}
//                if filteredFriends.count > 0 {
//                    let filterGroup = FriendList()
//                    filterGroup.title = group.title
//                    filterGroup.friends = filteredFriends
//                    filteredGroupedFriends.append(filterGroup)
//                }
//            }
//        }
//
//        self.tableView.reloadData()
//    }
//}

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        customControll.isHidden = searchActive
//        return groupedFriends.count
        return searchActive ? filteredGroupedFriends.count : groupedFriends.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return groupedFriends[section].friends.count
        return searchActive ? filteredGroupedFriends[section].friends.count : groupedFriends[section].friends.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendHeaderTableViewCell") as! FriendHeaderTableViewCell
        let friendGroup = searchActive ? filteredGroupedFriends[section] : groupedFriends[section]
        cell.labelTitle.text = friendGroup.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendTableViewCell", for: indexPath) as! FriendTableViewCell
        let friend = searchActive ? filteredGroupedFriends[indexPath.section].friends[indexPath.row] : groupedFriends[indexPath.section].friends[indexPath.row]
        cell.loadData(friend: friend)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        selectedSection = indexPath.section
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showFriend", sender: nil)
    }
    
}

extension FriendsViewController: FriendsViewControllerDelegate {
    
    func selectTitle(title: String) {
        for (index, char) in GlobalConstants.titles.enumerated() {
            if char == title {
                print ("Select section \(index)")
                let indexPath = IndexPath(row: NSNotFound, section: index)
                tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                break
            }
        }
    }
    
    
}




