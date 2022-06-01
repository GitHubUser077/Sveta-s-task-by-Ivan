//
//  StringExtension.swift
//  VKApp
//
//  Created by mac on 02.06.2022.
//

import Foundation


extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}
