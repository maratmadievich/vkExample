//
//  FriendHeaderCellPresenter.swift
//  homeWork_1
//
//  Created by Марат Нургалиев on 30/09/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol FriendHeaderCellPresenterProtocol {
	func getTitle() -> String
}

class FriendHeaderCellPresenter: FriendHeaderCellPresenterProtocol {
	
	private var friendList: FriendList
	
	init (friendList: FriendList) {
		self.friendList = friendList
	}
	
	func getTitle() -> String {
		let text = friendList.title
		return text
	}
	
}
