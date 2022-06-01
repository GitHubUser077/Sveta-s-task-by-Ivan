//
//  AuthorizationViewController.swift
//  VKApp
//
//  Created by mac on 31.05.2022.
//

import UIKit
import WebKit

class AuthorizationViewController: UIViewController {
    
    
        //MARK: - @IBOutlets
    @IBOutlet weak var webView: WKWebView!
    
    
        //MARK: - Properties
    var appID = "8178604"
    
    func loadAuthorization() {
        guard let url = URL(string: "https://oauth.vk.com/authorize?client_id=\(appID)&display=mobile&redirect_uri=https://oauth.vk.com/blank.html&scope=335878&response_type=token&v=5.68") else { return }
        
        let request = URLRequest(url: url)
        
        webView.load(request)
        
        
    }
    
    
        //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
//        loadAuthorization()
        authorize()
    }
    
    func authorize()  {
    var urlComponents = URLComponents(string: "https://oauth.vk.com/authorize")
    urlComponents?.queryItems = [
        URLQueryItem(name: "client_id", value: "8178604"),
        URLQueryItem(name: "display", value: "mobile"),
        URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
        URLQueryItem(name: "scope", value: "335878"),
        URLQueryItem(name: "response_type", value: "token"),
        URLQueryItem(name: "v", value: "5.68") ]
    
        guard let url = urlComponents?.url else {return}
        
        print("000000000000000000")
        print("\(url)")
        print("000000000000000000")
        
        let request = URLRequest(url: url)
        
        webView.load(request)
    }

  

}



extension AuthorizationViewController: WKNavigationDelegate {
   
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
       
        guard let url = navigationResponse.response.url,
            url.path == "/blank.html",
              let fragment = url.fragment else {
               decisionHandler(.allow)
                  return
              }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=")}
            .reduce([String: String](), { partialResult, param in
                var dict = partialResult
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            })
        
        guard let token = params["access_token"],
        let userID = params["user_id"] else {return}
        AuthorizationInfo.shared.token = token
        AuthorizationInfo.shared.userID = Int(userID)!
        
        
        let appTabBarController = storyboard?.instantiateViewController(withIdentifier: "AppTabBar") as! UITabBarController

        
        appTabBarController.modalPresentationStyle = .fullScreen
        appTabBarController.modalTransitionStyle = .flipHorizontal
        
        present(appTabBarController, animated: true, completion: nil)
        

    
        decisionHandler(.cancel)
            
    }
}
