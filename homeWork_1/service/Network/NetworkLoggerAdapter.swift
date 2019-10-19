//
//  NetworkProxyAdapter.swift
//  homeWork_1
//
//  Created by Mac on 19.10.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

class NetworkLoggerAdapter: NetworkAdapterInterface {
    
    private let networkAdapter: NetworkAdapter
    
    init(adapter: NetworkAdapter) {
        self.networkAdapter = adapter
    }
    
    internal func getFriends(delegate: VkApiFriendsDelegate) {
        print("LOG: use getFriends")
        networkAdapter.getFriends(delegate: delegate)
    }
    
    internal func getGroups(delegate: VkApiGroupsDelegate) {
        print("LOG: use getGroups")
        networkAdapter.getGroups(delegate: delegate)
    }
    
    internal func leaveGroup(gid: Int, delegate: VkApiGroupsDelegate) {
        print("LOG: use leaveGroup with gid = \(gid)")
        networkAdapter.leaveGroup(gid: gid, delegate: delegate)
    }
    
    internal func joinGroup(gid: Int, delegate: VkApiGroupsDelegate) {
        print("LOG: use joinGroup with gid = \(gid)")
        networkAdapter.joinGroup(gid: gid, delegate: delegate)
    }
    
    internal func searchGroups(search: String, delegate: VkApiGroupsDelegate) {
        print("LOG: use searchGroups with search = \(search)")
        networkAdapter.searchGroups(search: search, delegate: delegate)
    }
    
    internal func getPhotos(delegate: VkApiPhotosDelegate) {
        print("LOG: use getPhotos")
        networkAdapter.getPhotos(delegate: delegate)
    }
    
    internal func getPhotos(by id: Int, delegate: VkApiPhotosDelegate) {
        print("LOG: use getPhotos with id = \(id)")
        networkAdapter.getPhotos(by: id, delegate: delegate)
    }
    
    internal func getNews(startFrom: String, delegate: VkApiFeedsDelegate) {
        print("LOG: use getNews with startTime = \(startFrom)")
        networkAdapter.getPhotos(startFrom: startFrom, delegate: delegate)
    }
    
    internal func getComments(ownerId: Int, postId: Int, delegate: VkApiCommentsDelegate) {
        print("LOG: use getComments with ownerId = \(ownerId), postId = \(postId)")
        networkAdapter.getPhotos(ownerId: ownerId, postId: postId, delegate: delegate)
    }
    
}
