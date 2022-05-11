//
//  UIViewExtension.swift
//  Sveta's task by Ivan
//
//  Created by mac on 10.05.2022.
//

import UIKit

extension UIView {
   @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
