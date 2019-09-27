//
//  AlamofireService.swift
//  homeWork_1
//
//  Created by Admin on 06.11.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON



enum VkMethod: String {
	case getFriends = "friends.get"
	case getGroups = "groups.get"
	case leaveGroup = "groups.leave"
	case joinGroup = "groups.join"
	case searchGroup = "groups.search"
	case getPhotos = "photos.getAll"
	case getFeeds = "newsfeed.get"
	case getComments = "wall.getComments"
}

struct AlamofireServiceRequest {
	let fullRow: String
	let params: Parameters
	let httpMethod: HTTPMethod
}

class AlamofireService {
    
    static let shared = AlamofireService()
    private init(){}
	
	
	func getFriends(completion: @escaping ([VkFriend]) -> Void) {
		let parameters: Parameters = ["fields": "id,nickname,photo_100,status"]
		let request = makeRequest(vkMethod: .getFriends, httpMethod: .get, params: parameters)
		execute(request: request) { result in
			let friends = VkResponseParser.instance
				.parseFriends(result: result)
			DispatchQueue.main.async {
				completion(friends)
			}
		}
    }
	
    func getGroups(completion: @escaping ([VkGroup]) -> Void) {
		let parameters: Parameters = [
			"fields": "id,name",
			"extended": "1",
			"count":"100"]
		let request = makeRequest(vkMethod: .getGroups, httpMethod: .get, params: parameters)
		execute(request: request) { result in
			let groups =  VkResponseParser.instance
				.parseGroups(result: result, isSearched: false)
			DispatchQueue.main.async {
				completion(groups)
			}
		}
    }
    
    
    func leaveGroup(gid: Int, completion: @escaping (Bool) -> Void) {
		let parameters: Parameters = ["group_id": "\(gid)"]
		let request = makeRequest(vkMethod: .leaveGroup, httpMethod: .get, params: parameters)
		execute(request: request) { result in
			let parseValid = VkResponseParser.instance
				.parseJoinLeaveGroup(result: result)
			DispatchQueue.main.async {
				completion(parseValid)
			}
		}
    }
    
    
    func joinGroup(gid: Int, completion: @escaping (Bool) -> Void) {
		let parameters: Parameters = ["group_id": "\(gid)"]
		let request = makeRequest(vkMethod: .joinGroup, httpMethod: .get, params: parameters)
		execute(request: request) { result in
			let parseValid = VkResponseParser.instance
				.parseJoinLeaveGroup(result: result)
			DispatchQueue.main.async {
				completion(parseValid)
			}
		}
    }
    
    
    // //Группы Поиск
    func searchGroups(search: String, completion: @escaping ([VkGroup]) -> Void) {
		let parameters: Parameters = [
			"q": search,
			"extended": "1",
			"sort": "2"]
		let request = makeRequest(vkMethod: .searchGroup, httpMethod: .get, params: parameters)
		execute(request: request) { result in
			let groups = VkResponseParser.instance
				.parseGroups(result: result, isSearched: true)
			DispatchQueue.main.async {
				completion(groups)
			}
		}
    }
	
    func getPhotos(completion: @escaping ([VkPhoto]) -> Void) {
		let parameters: Parameters = [
			"extended": "1",
			"count":"100"]
		let request = makeRequest(vkMethod: .getPhotos, httpMethod: .get, params: parameters)
		execute(request: request) { result in
			let photos = VkResponseParser.instance
				.parsePhotos(result: result)
			DispatchQueue.main.async {
				completion(photos)
			}
		}
    }
    
    func getPhotos(by id: Int, completion: @escaping ([VkPhoto]) -> Void) {
		let parameters: Parameters = [
			"extended": "1",
			"owner_id":"\(id)",
			"count":"100"]
		let request = makeRequest(vkMethod: .getPhotos, httpMethod: .get, params: parameters)
		execute(request: request) { result in
			let photos = VkResponseParser.instance
				.parsePhotos(result: result)
			DispatchQueue.main.async {
				completion(photos)
			}
		}
    }
	
    func getNews(startFrom: String, completion: @escaping ([VkFeed]) -> Void) {
		let parameters: Parameters = [
			"filters": "post",
			"count":"20",
			"start_from":"\(startFrom)"]
		let request = makeRequest(vkMethod: .getFeeds, httpMethod: .get, params: parameters)
		execute(request: request) { result in
			let feeds = VkResponseParser.instance.parseNews(result: result)
			DispatchQueue.main.async {
				completion(feeds)
			}
		}
    }
    
    
    func getComments(ownerId: Int, postId: Int, completion: @escaping ([VkComment]) -> Void) {
		let parameters: Parameters = [
			"filters": "post",
			"count":"50",
			"sort":"desc",
			"need_likes":"1",
			"extended":"1",
			"owner_id":"\(ownerId)",
			"post_id":"\(postId)"]
		let request = makeRequest(vkMethod: .getFeeds, httpMethod: .get, params: parameters)
		execute(request: request) { result in
			let comments = VkResponseParser.instance
				.parseComments(result: result)
			DispatchQueue.main.async {
				completion(comments)
			}
		}
    }
	
	private func makeRequest(vkMethod: VkMethod, httpMethod: HTTPMethod, params: Parameters) -> AlamofireServiceRequest {
		let fullRow = "\(GlobalConstants.vkApi)\(vkMethod.rawValue)"
		var parameters = params
		parameters["v"] = "3.0"
		parameters["access_token"] = Session.instance.token
		return AlamofireServiceRequest(fullRow: fullRow, params: parameters, httpMethod: httpMethod)
	}
	
	private func execute(request: AlamofireServiceRequest, completion: @escaping(Result<Any>) -> Void) {
		Alamofire.request(request.fullRow, method: request.httpMethod, parameters: request.params)
			.responseJSON(queue: DispatchQueue.global(qos: .userInteractive)) { response in
				completion(response.result)
		}
	}
    
}

