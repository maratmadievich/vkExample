//
//  GroupCellAdapter.swift
//  homeWork_1
//
//  Created by Марат Нургалиев on 30/09/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol GroupCellPresenterProtocol {
	func getNameTitle() -> String
	func getTypeTitle() -> String
	func getMemberTitle() -> String
	func getImageUrl() -> URL?
	func getImagePlaceholder() -> UIImage
}

class GroupCellPresenter: GroupCellPresenterProtocol {
	
	private var group: VkGroup
	private let placeholder = UIImage(named: "noPhoto")
	
	init (group: VkGroup) {
		self.group = group
	}
	
	func getNameTitle() -> String {
		let text = group.name
		return text
	}
	
	func getTypeTitle() -> String {
		let text = group.getType()
		return text
	}
	
	func getMemberTitle() -> String {
		let text = group.is_member > 0
			? "Вы вступили"
			: ""
		return text
	}
	
	func getImageUrl() -> URL? {
		let url = URL(string: group.photoBig)
		return url
	}
	
	func getImagePlaceholder() -> UIImage {
		return placeholder ?? UIImage()
	}
	
}


