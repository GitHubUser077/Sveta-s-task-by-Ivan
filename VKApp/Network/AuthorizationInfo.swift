//
//  AuthorizationInfo.swift
//  VKApp
//
//  Created by mac on 31.05.2022.
//

import Foundation

class AuthorizationInfo {
    
    static var shared = AuthorizationInfo()
    
    private init() {}
    
    var token: String = ""
    var userID: Int = 0
    
}
