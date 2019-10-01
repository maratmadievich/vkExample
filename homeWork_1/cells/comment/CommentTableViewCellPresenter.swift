//
//  CommentTableViewCellAdapter.swift
//  homeWork_1
//
//  Created by Марат Нургалиев on 30/09/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol CommentCellPresenterProtocol {
	func getNameTitle() -> String
	func getTextTitle() -> String
	func getImageUrl() -> URL?
	func getImagePlaceholder() -> UIImage
}

class CommentCellPresenter: CommentCellPresenterProtocol {
	
	private var comment: VkComment
	private let placeholder = UIImage(named: "noPhoto")
	
	init (comment: VkComment) {
		self.comment = comment
	}
	
	func getNameTitle() -> String {
		let text = comment.sender.getFullName()
		return text
	}
	
	func getTextTitle() -> String {
		let text = comment.text
		return text
	}
	
	func getImageUrl() -> URL? {
		let url = URL(string: comment.sender.imageUrl100)
		return url
	}
	
	func getImagePlaceholder() -> UIImage {
		return placeholder ?? UIImage()
	}
	
}
