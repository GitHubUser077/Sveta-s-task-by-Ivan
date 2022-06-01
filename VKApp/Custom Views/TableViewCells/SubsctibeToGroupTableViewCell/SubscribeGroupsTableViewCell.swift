//
//  SubscribeGroupsTableViewCell.swift
//  Sveta's task by Ivan
//
//  Created by mac on 16.05.2022.
//

import UIKit

protocol SubscribeGroupsTableViewCellProtocol: AnyObject {
    func onButtonTap(sender: SubscribeGroupsTableViewCell)
}

class SubscribeGroupsTableViewCell: UITableViewCell {
    
        //MARK: - Static
    static let identifier = String(describing: SubscribeGroupsTableViewCell.self)
    static func nib() -> UINib {
        return UINib(nibName: String(describing: SubscribeGroupsTableViewCell.self), bundle: nil)
    }
    
        //MARK: - @IBOutlets

    @IBOutlet var groupImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subscribeButton: UIButton! 

    
    
        //MARK: - Properties
    
    var userId: UUID?
    
    var cellGroup: SimpleGroup? {
        didSet {
            
            if let group = cellGroup, let userID = userId {
                if group.users.contains(where: { $0.id == userID }) {
                    subscribeButton.setTitle("Unsubscribe", for: .normal)
                    subscribeButton.setTitleColor(.red, for: .normal)
                } else {
                    subscribeButton.setTitle("Subscribe", for: .normal)
                    subscribeButton.setTitleColor(.systemGreen, for: .normal)
                }
            }
            
        }
    }
    
    
        //MARK: - Delegation
    
    var delegate: SubscribeGroupsTableViewCellProtocol?
    
    
        //MARK: - @IBActions
    
        
    @IBAction func didTapBSubcribeButton(_ sender: Any) {
        cellGroup?.isSubscribedToUser.toggle()
        delegate?.onButtonTap(sender: self)
    }
    
    

    

    
        //MARK: - Public Methods
    
    func configure(with model: SimpleGroup) {
        cellGroup = model
        groupImageView.image = UIImage(named: model.thumbnailPhoto.name)
        titleLabel.text = model.name
        
    }
    
    
}
