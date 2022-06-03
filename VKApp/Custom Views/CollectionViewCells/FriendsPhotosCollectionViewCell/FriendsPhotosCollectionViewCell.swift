//
//  FriendsPhotosCollectionViewCell.swift
//  Sveta's task by Ivan
//
//  Created by mac on 11.05.2022.
//

import UIKit

class FriendsPhotosCollectionViewCell: UICollectionViewCell {
    
        //MARK: - Static
    
    static let identifier = String(describing: FriendsPhotosCollectionViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: String(describing: FriendsPhotosCollectionViewCell.self), bundle: nil)
    }
    
        //MARK: - @IBOutlets
    @IBOutlet var friendPhotoImageView: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
  
    
        //MARK: - Public Methods
    public func configure(with model: Photo) {
        activityIndicator.startAnimating()
        friendPhotoImageView.load(url: model.sizes.first?.url.asUrl) {
            
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
    
    
    
}
