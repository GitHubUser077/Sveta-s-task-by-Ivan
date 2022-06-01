//
//  User.swift
//  Sveta's task by Ivan
//
//  Created by mac on 07.05.2022.
//

import Foundation

struct InternetUser {
    let id: Int
    let name: String
    var thumbnailPhoto: InternetPhoto = InternetPhoto(id: 0, url: "")
    var isSubscribed = false
    
    var photos: [InternetPhoto] = []
}



struct FriendsResponse: Codable {
    let response: Response
}

 struct Response : Codable {
    //let count: Int
    let users: [User]

    enum CodingKeys: String, CodingKey {
        case users = "items"
    }
}

 struct User: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let thumbnailPhoto: String
     
     var fullName: String {
         return lastName + " " + firstName
     }

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case thumbnailPhoto = "photo_100"
        }
    }


