//
//  UIImageExtension.swift
//  VKApp
//
//  Created by mac on 02.06.2022.
//

import Foundation
import UIKit

extension UIImageView {
    
    func load(url: URL?) {
        guard let url = url else {
            print("Invalid url for image")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, erro in
            guard let data = data else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = UIImage(data: data)
            }
        }.resume()
    }
    
}




