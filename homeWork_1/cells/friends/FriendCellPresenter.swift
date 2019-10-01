//
//  FriendCellPresenter.swift
//  homeWork_1
//
//  Created by Марат Нургалиев on 30/09/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol FriendCellPresenterProtocol {
	func getNameTitle() -> String
	func getImageUrl() -> URL?
	func getImagePlaceholder() -> UIImage
}

class FriendCellPresenter: FriendCellPresenterProtocol {
	
	private var friend: VkFriend
	private let placeholder = UIImage(named: "noPhoto")
	
	init (friend: VkFriend) {
		self.friend = friend
	}
	
	func getNameTitle() -> String {
		let text = friend.full_name
		return text
	}
	
	func getImageUrl() -> URL? {
		let url = URL(string: friend.photo)
		return url
	}
	
	func getImagePlaceholder() -> UIImage {
		return placeholder ?? UIImage()
	}
	
}

