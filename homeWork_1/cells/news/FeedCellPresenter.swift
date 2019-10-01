//
//  FeedCellPresenter.swift
//  homeWork_1
//
//  Created by Марат Нургалиев on 01/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

protocol FeedCellPresenterProtocol {
	func getFeedGroupTitle() -> String
	func getDateTitle() -> String
	func getFeedTitle() -> String
	
	func getImageUrl() -> URL?
	func getSourceImageUrl() -> URL?
	func getImagePlaceholder() -> UIImage
	func getImageHeight(width: CGFloat) -> CGFloat
	
	func getLikeCountTitle() -> String
	func getViewsCountTitle() -> String
	func getSharesCountTitle() -> String
	func getCommentsCountTitle() -> String
	
	func haveImage() -> Bool
	func haveText() -> Bool
}

class FeedCellPresenter: FeedCellPresenterProtocol {
	
	private var feed: VkFeed
	
	init(feed: VkFeed) {
		self.feed = feed
	}
	
	func getFeedGroupTitle() -> String {
		let text = feed.sourceName
		return text
	}
	
	func getDateTitle() -> String {
		let text = getTimeLeft(from: feed.feedDate)
		return text
	}
	
	func getFeedTitle() -> String {
		let text = feed.feedText
		return text
	}
	
	func getImageUrl() -> URL? {
		let url = URL(string: feed.attachments[0].imageUrl)
		return url
	}
	
	func getImageHeight(width: CGFloat) -> CGFloat {
		let height = width * CGFloat(feed.attachments[0].height) / CGFloat(feed.attachments[0].width)
		return height
	}
	
	func getSourceImageUrl() -> URL? {
		let url = URL(string: feed.sourceUrl)
		return url
	}
	
	func getImagePlaceholder() -> UIImage {
		let image = UIImage(named: "noPhoto") ?? UIImage()
		return image
	}
	
	func getLikeCountTitle() -> String {
		let text = getStringFrom(count: feed.countLikes)
		return text
	}
	
	func getViewsCountTitle() -> String {
		let text = getStringFrom(count: feed.countViews)
		return text
	}
	
	func getSharesCountTitle() -> String {
		let text = getStringFrom(count: feed.countReposts)
		return text
	}
	
	func getCommentsCountTitle() -> String {
		let text = getStringFrom(count: feed.countComments)
		return text
	}
	
	func haveImage() -> Bool {
		let haveImage = feed.attachments.count > 0
		return haveImage
	}
	
	func haveText() -> Bool {
		let haveText = feed.feedText.count > 0
		return haveText
	}
	
}

extension FeedCellPresenter {
	
	private func getTimeLeft(from feedDate: Int) -> String {
		
		let currentDate = Date().timeIntervalSince1970
		let diffInSeconds = currentDate - Double(feedDate)
		let diffInMinutes = diffInSeconds/60
		let diffInHours = diffInMinutes/60
		let diffInDays = diffInMinutes/24
		
		if (diffInDays < 1
			&& diffInHours < 1
			&& diffInMinutes < 1
			&& diffInSeconds < 60) {
			return "\(Int(diffInSeconds)) секунд назад"
		} else if (diffInDays < 1
			&& diffInHours < 1
			&& diffInMinutes < 60) {
			return "\(Int(diffInMinutes)) минут назад"
		} else if (diffInDays < 1
			&& diffInHours < 24) {
			return "\(Int(diffInHours)) часов назад"
		} else {
			return "\(Int(diffInDays)) дней назад"
		}
	}
	
	private func getStringFrom(count: Int) -> String {
		if count > 1000000 {
			return String(format: "%.2f М ", Float(count)/1000000)
		} else if count > 1000 {
			return String(format: "%.2f К ", Float(count)/1000)
		} else if count > 0 {
			return "\(count)"
		} else {
			return ""
		}
	}
}
