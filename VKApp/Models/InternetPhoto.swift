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
