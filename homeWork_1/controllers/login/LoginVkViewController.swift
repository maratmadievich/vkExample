//
//  LoginVkViewController.swift
//  homeWork_1
//
//  Created by Admin on 23.10.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit
import WebKit

class LoginVkViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    let session = Session.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadVK()
    }
    
    
    private func loadVK() {webView.navigationDelegate = self
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "6729130"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.87")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        webView.navigationDelegate = self
        webView.load(request)
    }


}

extension LoginVkViewController: WKNavigationDelegate {
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        if let token = params["access_token"] {
            session.token = token
            print("access_token = \(token)")
        }
        if let userId = params["user_id"] {
            session.userId = Int(userId) ?? -1
            print("user_id = \(userId)")
        }
        
        decisionHandler(.cancel)
        performSegue(withIdentifier: "showApi", sender: nil)
    }

}