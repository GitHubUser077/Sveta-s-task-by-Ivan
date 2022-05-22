//
//  FriendsTableViewCell.swift
//  Sveta's task by Ivan
//
//  Created by mac on 10.05.2022.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {
    
        //MARK: - Static
    
    static let identifier = String(describing: FriendsTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: String(describing: FriendsTableViewCell.self), bundle: nil)
    }
    
    
        //MARK: - @IBOutlets
    
    
    @IBOutlet weak var friendImageView: UIImageView!
    @IBOutlet weak var friendLabel: UILabel!
    
    
    
    func configure(with model: SimpleUser) {
        friendLabel.text = model.name
        friendImageView.image = UIImage(named: model.avatarImage)
    }
   
    
}
