//
//  InternetPhoto.swift
//  VKApp
//
//  Created by mac on 01.06.2022.
//

import Foundation


struct InternetPhoto: Codable {
    var id: Int
    var url: String
    var likesCount: Int = 0
    var isLiked = false
}



 struct PhotoResponse: Codable {
    let response: PhotoInfo
}

 struct PhotoInfo : Codable {
    let count: Int
    let photos: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case photos = "items"
    }
}

 struct Photo: Codable {
    let id: Int
    let sizes: [Sizes]
    let likes: Likes
    
    enum CodingKeys: String, CodingKey {
        case id
        case sizes
        case likes
        }
    }

 struct Sizes: Codable {
    let url: String
   
}

 struct Likes: Codable {
    let user_likes: Int
    let count: Int
}
