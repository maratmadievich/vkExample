//
//  NetworkInterface.swift
//  homeWork_1
//
//  Created by Mac on 19.10.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol VkApiFriendsDelegate {
    func returnFriends(_ friends: [VkFriend])
}

protocol VkApiGroupsDelegate {
    func returnGroups(_ groups: [VkGroup])
    func returnLeave(_ gid: Int)
    func returnLeave(_ error: String)
    func returnJoin(_ gid: Int)
    func returnJoin(_ error: String)
}

protocol VkApiPhotosDelegate {
    func returnPhotos(_ photos: [VkPhoto])
}

protocol VkApiFeedsDelegate {
    func returnFeeds(_ feeds: [VkFeed])
}

protocol VkApiCommentsDelegate {
    func returnComments(_ comments: [VkComment])
}

protocol NetworkAdapterInterface {
    func getFriends(delegate: VkApiFriendsDelegate)
    func getGroups(delegate: VkApiGroupsDelegate)
    func leaveGroup(gid: Int, delegate: VkApiGroupsDelegate)
    func joinGroup(gid: Int, delegate: VkApiGroupsDelegate)
    func searchGroups(search: String, delegate: VkApiGroupsDelegate)
    func getPhotos(delegate: VkApiPhotosDelegate)
    func getPhotos(by id: Int, delegate: VkApiPhotosDelegate)
    func getNews(startFrom: String, delegate: VkApiFeedsDelegate)
    func getComments(ownerId: Int, postId: Int, delegate: VkApiCommentsDelegate)
}
