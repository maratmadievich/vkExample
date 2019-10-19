//
//  NetworkAdapter.swift
//  homeWork_1
//
//  Created by Марат Нургалиев on 27/09/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

class NetworkAdapter: NetworkAdapterInterface {
	private let service = AlamofireService.shared
	
	public func getFriends(delegate: VkApiFriendsDelegate) {
		service.getFriends { friends in
			delegate.returnFriends(friends)
		}
	}
	
	public func getGroups(delegate: VkApiGroupsDelegate) {
		service.getGroups { groups in
			delegate.returnGroups(groups)
		}
	}
	
	public func leaveGroup(gid: Int, delegate: VkApiGroupsDelegate) {
		service.leaveGroup(gid: gid) { isSuccess in
			isSuccess
				? delegate.returnLeave(gid)
				: delegate.returnLeave("В ходе запроса произошла ошибка")
		}
	}
	
	public func joinGroup(gid: Int, delegate: VkApiGroupsDelegate) {
		service.joinGroup(gid: gid) { isSuccess in
			isSuccess
				? delegate.returnJoin(gid)
				: delegate.returnJoin("В ходе запроса произошла ошибка")
		}
	}
	
	public func searchGroups(search: String, delegate: VkApiGroupsDelegate) {
		service.searchGroups(search: search) { groups in
			delegate.returnGroups(groups)
		}
	}
	
	public func getPhotos(delegate: VkApiPhotosDelegate) {
		service.getPhotos { photos in
			delegate.returnPhotos(photos)
		}
	}
	
	public func getPhotos(by id: Int, delegate: VkApiPhotosDelegate) {
		service.getPhotos(by: id) { photos in
			delegate.returnPhotos(photos)
		}
	}
	
	public func getNews(startFrom: String, delegate: VkApiFeedsDelegate) {
		service.getNews(startFrom: startFrom) { feeds in
			delegate.returnFeeds(feeds)
		}
	}
	
	public func getComments(ownerId: Int, postId: Int, delegate: VkApiCommentsDelegate)  {
		service.getComments(ownerId: ownerId, postId: postId) { comments in
			delegate.returnComments(comments)
		}
	}
	
	
}
