//
//  CellPresenterFactory.swift
//  homeWork_1
//
//  Created by Марат Нургалиев on 30/09/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

class CellPresenterFactory {
	
	internal func makeGroupCellPresenter(group: VkGroup) -> GroupCellPresenterProtocol {
		return GroupCellPresenter(group: group)
	}
	
	internal func makeFriendCellPresenter(friend: VkFriend) -> FriendCellPresenterProtocol {
		return FriendCellPresenter(friend: friend)
	}
	
	internal func makeFriendHeaderPresenter(friendList: FriendList) -> FriendHeaderCellPresenterProtocol {
		return FriendHeaderCellPresenter(friendList: friendList)
	}
	
	internal func makeCommentCellPresenter(commnent: VkComment) -> CommentCellPresenterProtocol {
		return CommentCellPresenter(comment: commnent)
	}
	
	internal func makeFeedCellPresenter(feed: VkFeed) -> FeedCellPresenterProtocol {
		return FeedCellPresenter(feed: feed)
	}
	
}
