//
//  CardView.swift
//  Sveta's task by Ivan
//
//  Created by mac on 10.05.2022.
//

import UIKit

class CardView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
    
    private func initialSetup() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.cornerRadius = 10
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 10
        
        layer.cornerRadius = 10
    }
    
}
