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
    
    
    //MARK: - Lifecycle

override func prepareForReuse() {
    super.prepareForReuse()
    friendImageView.image = nil
    friendLabel.text = nil
}
    
    
    func configure(with model: User) {
        friendLabel.text = "\(model.lastName) \(model.firstName)"
        friendImageView.load(url: model.thumbnailPhoto.asUrl) { _ in }
    }
   
    
}
