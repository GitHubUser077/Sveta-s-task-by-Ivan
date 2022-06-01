//
//  API.swift
//  VKApp
//
//  Created by mac on 02.06.2022.
//

import Foundation


struct API {
    
    
    static func urlForFriends() -> URL? {
        
        var urlConstructor = URLComponents()
                urlConstructor.scheme = "https"
                urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/friends.get"
                urlConstructor.queryItems = [
                    URLQueryItem(name: "access_token", value: String(AuthorizationInfo.shared.token)),
                    URLQueryItem(name: "v", value: "5.131"),
                    URLQueryItem(name: "user_id", value: String(AuthorizationInfo.shared.userID)),
                    URLQueryItem(name: "fields", value: "photo_100")
                ]
            guard let url = urlConstructor.url else { return nil }
        
        return url
    }
    
    static func urlForPhotos(userId: Int) -> URL? {
        
        var urlConstructor = URLComponents()
                urlConstructor.scheme = "https"
                urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/photos.getAll"
                urlConstructor.queryItems = [
                    URLQueryItem(name: "access_token", value: String(AuthorizationInfo.shared.token)),
                    URLQueryItem(name: "v", value: "5.131"),
                    URLQueryItem(name: "user_id", value: String(AuthorizationInfo.shared.userID)),
                    URLQueryItem(name: "count", value: "200"),
                    URLQueryItem(name: "extended", value: "1"),
                    URLQueryItem(name: "owner_id", value: String(userId))
                ]
            guard let url = urlConstructor.url else { return nil }
        
        return url
    }
    
    
}
