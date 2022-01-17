//
//  VKLoginViewController.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 16.01.2022.
//

import UIKit
import WebKit

class VKLoginViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var webView: WKWebView!
    
    //MARK: - Vars
    var session = Session.shared
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        loginToVK()
        webView.navigationDelegate = self
    }
}

extension VKLoginViewController: WKNavigationDelegate {
    
    //MARK: - Delegate
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard
            let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment
        else {
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
        
        if let token = params["access_token"],
           let userId = params["user_id"] {
            session.token = token
            session.userId = Int(userId)
            print (token)
            print (userId)
            decisionHandler(.cancel)
            performSegue(withIdentifier: "vkSegue", sender: self)
        }
    }
    
    //MARK: - Request
    func loginToVK() {
        var fullURL = URLComponents()
        fullURL.scheme = "https"
        fullURL.host = "oauth.vk.com"
        fullURL.path = "/authorize"
        fullURL.queryItems = [
            URLQueryItem(name: "client_id", value: "7809061"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let request = URLRequest(url: fullURL.url!)
        webView.load(request)
    }
}
